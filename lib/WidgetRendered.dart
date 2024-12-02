import 'package:flutter/material.dart';

import 'main.dart';

class DynamicWidgetBuilder {
  
  static Widget buildWidget(Map<String, dynamic> widgetConfig) {
  
   

    switch (widgetConfig['type']) {
      case 'container':
        return Container(
          width: widgetConfig['width']?.toDouble(),
          decoration: BoxDecoration(
            color: _parseColor(
                widgetConfig['color'] ?? "#FFFFFF"), // Default to white

            borderRadius:
                _parseBorderRadius(widgetConfig['borderRadius']?.toString()),
          ),
          height: widgetConfig['height']?.toDouble(),
          alignment: _parseAlignment(widgetConfig['alignment']),
          margin: _parseMargin(widgetConfig['margin']),
          child: widgetConfig['child'] != null
              ? buildWidget(widgetConfig['child'])
              : null,
        );

      case 'padding':
        return Padding(
          padding: _parsePadding(widgetConfig['padding']),
          child: buildWidget(widgetConfig['child']),
        );

      case 'text':
        return Align(
          alignment: _parseAlignment(widgetConfig['alignment']),
          child: Text(
            widgetConfig['data'] ?? '',
            style: TextStyle(
              fontSize: widgetConfig['style']?['fontSize']?.toDouble(),
              color: _parseColor(widgetConfig['style']?['color']),
              fontWeight:
                  _parseFontWeight(widgetConfig['style']?['fontWeight']),
            ),
          ),
        );
      case 'sizebox':
        return SizedBox(
          height: widgetConfig['height']?.toDouble(),
          width: widgetConfig['width']?.toDouble(),
        );
    case 'image':
  return ClipRRect(
    borderRadius: widgetConfig['borderRadius'] != null
        ? _parseBorderRadius(widgetConfig['borderRadius'].toString())
        : BorderRadius.zero, // Default to no curve
    child: Align(
      alignment: _parseAlignment(widgetConfig['alignment']),
      child: Image.network(
        widgetConfig['url'] ?? '',
        width: widgetConfig['width']?.toDouble(),
        height: widgetConfig['height']?.toDouble(),
        fit: _parseBoxFit(widgetConfig['fit']),
      ),
    ),
  );

      case 'button':
        return Align(
          alignment: _parseAlignment(widgetConfig['alignment']),
          child: SizedBox(
            width: widgetConfig['width']?.toDouble(),
            height: widgetConfig['height']?.toDouble(),
            child: ElevatedButton(
               onPressed: () {
                final route = widgetConfig['onPressed'];
                if (route != null) {
                  navigatorKey.currentState?.pushNamed(route);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  _parseColor(widgetConfig['color']),
                ),
              ),
              child: Text(widgetConfig['label'] ?? 'Button'),
            ),
          ),
        );

      case 'singlechildscrollview':
        return SingleChildScrollView(
          padding: _parsePadding(widgetConfig['padding']),
          scrollDirection: _parseScroll(widgetConfig['scrollDirection']),
          child: buildWidget(widgetConfig['child']),
        );

      case 'textfield':
        return TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: widgetConfig['hint'],
            labelText: widgetConfig['label'],
          ),
        );

      case 'row':
        return Row(
          mainAxisAlignment:
              _parseMainAxisAlignment(widgetConfig['mainAxisAlignment']),
          crossAxisAlignment:
              _parseCrossAxisAlignment(widgetConfig['crossAxisAlignment']),
          children: _buildChildren(widgetConfig['children']),
        );
      case 'column':
        return Column(
          mainAxisAlignment:
              _parseMainAxisAlignment(widgetConfig['mainAxisAlignment']),
          crossAxisAlignment:
              _parseCrossAxisAlignment(widgetConfig['crossAxisAlignment']),
          children: _buildChildren(widgetConfig['children']),
        );

    case 'alignment':
        return Align(
          alignment: _parseAlignment(widgetConfig['alignment']),
          child: buildWidget(widgetConfig['child']),
        );

      default:
        throw ArgumentError("Unknown widget type: ${widgetConfig['type']}");
    }
  }

  static List<Widget> _buildChildren(List<dynamic>? children) {
    if (children == null) return [];
    return children.map((child) => buildWidget(child)).toList();
  }

  static Color? _parseColor(dynamic color) {
    try {
      if (color == null) return null;

      if (color is int) {
        return Color(color);
      } else if (color is String) {
        if (color.startsWith("#")) {
          return Color(int.parse(color.substring(1), radix: 16) + 0xFF000000);
        }
      }
      throw ArgumentError("Invalid color value: $color.");
    } catch (e) {
      debugPrint("Error parsing color: $e");
      return null; // Default to transparent color or null
    }
  }

  static Alignment _parseAlignment(String? alignment) {
    switch (alignment) {
      case 'center':
        return Alignment.center;
      case 'topCenter':
        return Alignment.topCenter;
      case 'bottomCenter':
        return Alignment.bottomCenter;
      case 'topLeft':
        return Alignment.topLeft;
      case 'topRight':
        return Alignment.topRight;
      default:
        return Alignment.center;
    }
  }

  static EdgeInsets _parsePadding(String? padding) {
    switch (padding) {
      case 'all':
        return const EdgeInsets.all(15);
      case 'top':
        return const EdgeInsets.only(top: 10);
      case 'bottom':
        return const EdgeInsets.only(bottom: 10);
      case 'left':
        return const EdgeInsets.only(left: 10);
      case 'right':
        return const EdgeInsets.only(right: 10);
      default:
        return const EdgeInsets.all(10);
    }
  }

  static Axis _parseScroll(String? scrollDirection) {
    Axis axis;
    switch (scrollDirection) {
      case 'horizontal':
        axis = Axis.horizontal;
        break;
      case 'vertical':
        axis = Axis.vertical;
        break;
      default:
        axis = Axis.vertical; // or throw an exception
    }
    return axis;
  }

  static EdgeInsets _parseMargin(String? margin) {
    switch (margin) {
      case 'all':
        return const EdgeInsets.all(10);
      case 'top':
        return const EdgeInsets.only(top: 10);
      case 'bottom':
        return const EdgeInsets.only(bottom: 10);
      case 'left':
        return const EdgeInsets.only(left: 10);
      case 'right':
        return const EdgeInsets.only(right: 10);

      default:
        return const EdgeInsets.all(10);
    }
  }

  static BoxFit _parseBoxFit(String? fit) {
    switch (fit) {
      case 'cover':
        return BoxFit.cover;
      case 'contain':
        return BoxFit.contain;
      default:
        return BoxFit.contain;
    }
  }

static BorderRadius _parseBorderRadius(dynamic border) {
  if (border == null) return BorderRadius.zero;
  
  // If border is a number, create circular border radius
  if (border is String && double.tryParse(border) != null) {
    return BorderRadius.circular(double.parse(border));
  }
  
  return BorderRadius.zero; // Default to no curve if parsing fails
}


  static FontWeight _parseFontWeight(String? fontWeight) {
    switch (fontWeight) {
      case 'bold':
        return FontWeight.bold;
      case 'normal':
        return FontWeight.normal;
      default:
        return FontWeight.normal;
    }
  }

  static MainAxisAlignment _parseMainAxisAlignment(String? mainAxisAlignment) {
    switch (mainAxisAlignment) {
      case 'start':
        return MainAxisAlignment.start;
      case 'end':
        return MainAxisAlignment.end;
      case 'center':
        return MainAxisAlignment.center;
      case 'spaceBetween':
        return MainAxisAlignment.spaceBetween;
      case 'spaceAround':
        return MainAxisAlignment.spaceAround;
      case 'spaceEvenly':
        return MainAxisAlignment.spaceEvenly;
      default:
        return MainAxisAlignment.start;
    }
  }

  static CrossAxisAlignment _parseCrossAxisAlignment(
      String? crossAxisAlignment) {
    switch (crossAxisAlignment) {
      case 'start':
        return CrossAxisAlignment.start;
      case 'end':
        return CrossAxisAlignment.end;
      case 'center':
        return CrossAxisAlignment.center;
      case 'stretch':
        return CrossAxisAlignment.stretch;
      case 'baseline':
        return CrossAxisAlignment.baseline;
      default:
        return CrossAxisAlignment.start;
    }
  }
}
