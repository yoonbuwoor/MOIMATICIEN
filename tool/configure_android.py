from pathlib import Path
import re
import shutil

ROOT = Path(__file__).resolve().parents[1]
ANDROID = ROOT / 'android'
APP = ANDROID / 'app'

manifest = APP / 'src' / 'main' / 'AndroidManifest.xml'
if manifest.exists():
    text = manifest.read_text(encoding='utf-8')
    text = re.sub(
        r'android:label="[^"]+"',
        'android:label="Moi Géomaticien"',
        text,
        count=1,
    )
    manifest.write_text(text, encoding='utf-8')

icon_root = ROOT / 'tool' / 'icons'
res_root = APP / 'src' / 'main' / 'res'
for source_dir in icon_root.glob('mipmap-*'):
    source = source_dir / 'ic_launcher.png'
    if source.exists():
        target_dir = res_root / source_dir.name
        target_dir.mkdir(parents=True, exist_ok=True)
        shutil.copy2(source, target_dir / 'ic_launcher.png')

launch_background = '''<?xml version="1.0" encoding="utf-8"?>
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item>
        <shape android:shape="rectangle">
            <solid android:color="#650238" />
        </shape>
    </item>
    <item android:gravity="center" android:width="180dp" android:height="180dp">
        <bitmap android:gravity="center" android:src="@mipmap/ic_launcher" />
    </item>
</layer-list>
'''
for drawable_name in ('drawable', 'drawable-v21'):
    drawable_dir = res_root / drawable_name
    drawable_dir.mkdir(parents=True, exist_ok=True)
    (drawable_dir / 'launch_background.xml').write_text(
        launch_background,
        encoding='utf-8',
    )

gradle = APP / 'build.gradle.kts'
if gradle.exists():
    text = gradle.read_text(encoding='utf-8')
    text = re.sub(
        r'namespace\s*=\s*"[^"]+"',
        'namespace = "com.novateur221.moi_geomaticien"',
        text,
        count=1,
    )
    text = re.sub(
        r'applicationId\s*=\s*"[^"]+"',
        'applicationId = "com.novateur221.moi_geomaticien"',
        text,
        count=1,
    )
    text = re.sub(r'minSdk\s*=\s*[^\n]+', 'minSdk = 24', text, count=1)

    if 'import java.io.FileInputStream' not in text:
        text = 'import java.io.FileInputStream\nimport java.util.Properties\n\n' + text

    keystore_block = '''val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

'''
    if 'val keystoreProperties = Properties()' not in text:
        text = text.replace('android {', keystore_block + 'android {', 1)

    signing_block = '''    signingConfigs {
        if (keystorePropertiesFile.exists()) {
            create("release") {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
    }

'''
    if 'create("release")' not in text:
        text = text.replace('    buildTypes {', signing_block + '    buildTypes {', 1)

    release_signing = (
        'signingConfig = if (keystorePropertiesFile.exists()) '
        'signingConfigs.getByName("release") else signingConfigs.getByName("debug")'
    )
    text = text.replace(
        'signingConfig = signingConfigs.getByName("debug")',
        release_signing,
    )
    gradle.write_text(text, encoding='utf-8')

main_activity = (
    APP
    / 'src'
    / 'main'
    / 'kotlin'
    / 'com'
    / 'novateur221'
    / 'moi_geomaticien'
    / 'MainActivity.kt'
)
main_activity.parent.mkdir(parents=True, exist_ok=True)
main_activity.write_text(
    '''package com.novateur221.moi_geomaticien

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity()
''',
    encoding='utf-8',
)

print('Configuration Android de Moi Géomaticien appliquée.')
