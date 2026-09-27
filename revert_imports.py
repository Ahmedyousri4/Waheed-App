import os

files = ['lib/views/home/all_categories.dart', 'lib/views/home/latest_products.dart', 'lib/views/home/widgets/favorite.dart', 'lib/views/product/product_details.dart']
for file_path in files:
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    content = content.replace("import 'package:waheed/views/home/home.dart';\nimport 'package:waheed/views/home/widgets/product_card.dart';", "import 'package:waheed/views/home/home.dart';")
    content = content.replace("import 'package:waheed/views/home/widgets/product_card.dart';", "import 'package:waheed/views/home/home.dart';")
    content = content.replace("import 'package:waheed/views/home/home_components.dart';", "")
    
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(content)
