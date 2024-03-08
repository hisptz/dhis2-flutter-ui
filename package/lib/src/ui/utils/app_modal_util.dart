import 'package:flutter/material.dart';

/// Utility class for showing modal in a application.
class AppModalUtil {
  /// Shows an action sheet modal with a custom container.
  ///
  /// This method uses [showModalBottomSheet] from Flutter's Material library to
  /// display the action sheet.
  ///
  /// Parameters:
  /// - context: The BuildContext required for the showModalBottomSheet method.
  /// - actionSheetContainer: The widget that represents the content of the action
  ///   sheet.
  /// - initialHeightRatio: The initial height ratio of the action sheet. Defaults
  ///   to 0.3.
  /// - minHeightRatio: The minimum height ratio of the action sheet. Defaults to
  ///   0.1.
  /// - maxHeightRatio: The maximum height ratio of the action sheet. Defaults to
  ///   0.85.
  /// - topBorderRadius: The top border radius of the action sheet. Defaults to
  ///   20.0.
  static Future showActionSheetModal({
    required BuildContext context,
    required Widget actionSheetContainer,
    double initialHeightRatio = 0.3,
    double minHeightRatio = 0.1,
    double maxHeightRatio = 0.85,
    double topBorderRadius = 20.0,
  }) {
    // Ensures that the maxHeightRatio is not greater than 0.85 if it's less than
    // the initialHeightRatio.
    maxHeightRatio = maxHeightRatio > 0 ? maxHeightRatio : 0.85;

    // showModalBottomSheet is a Flutter method that displays a bottom sheet,
    // which is a piece of secondary content that slides up from the bottom of
    // the screen.
    return showModalBottomSheet(
      context: context, // The BuildContext required for showModalBottomSheet.
      isDismissible: false, // Whether the user can dismiss the bottom sheet by
      // dragging it down.
      isScrollControlled: true, // Whether the bottom sheet can be scrolled.
      backgroundColor: Colors.transparent, // Transparent background color.
      builder: (context) => GestureDetector(
        // A GestureDetector widget that detects gestures and triggers callbacks
        // when a gesture is recognized.
        behavior: HitTestBehavior.opaque, // Makes the GestureDetector opaque.
        onTap: () => Navigator.of(context).pop(), // Closes the bottom sheet.
        child: GestureDetector(
          // Another GestureDetector that does not react to taps.
          onTap: () {},
          child: DraggableScrollableSheet(
            // A scrollable sheet that can be dragged to reveal or hide its content.
            initialChildSize: initialHeightRatio, // Initial height ratio.
            maxChildSize: maxHeightRatio < initialHeightRatio
                ? initialHeightRatio
                : maxHeightRatio, // Maximum height ratio.
            minChildSize: minHeightRatio < initialHeightRatio
                ? minHeightRatio
                : initialHeightRatio, // Minimum height ratio.
            builder: (
              BuildContext context,
              ScrollController scrollController,
            ) {
              // The builder function that returns the content of the sheet.
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ), // Adds padding to the bottom of the sheet to avoid covering
                // the on-screen keyboard.
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // White background color.
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(topBorderRadius),
                    ), // Top border radius.
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 1.0,
                    ), // Horizontal margin for the inner container.
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(topBorderRadius),
                      ), // Top border radius for the inner container.
                    ),
                    child:
                        actionSheetContainer, // Dynamic widget for content of a specific action sheet
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
