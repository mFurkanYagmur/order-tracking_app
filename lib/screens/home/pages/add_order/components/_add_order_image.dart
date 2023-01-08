part of '../add_order_page.dart';

class _AddOrderImage extends StatefulWidget {
  const _AddOrderImage({Key? key}) : super(key: key);

  @override
  State<_AddOrderImage> createState() => _AddOrderImageState();
}

class _AddOrderImageState extends State<_AddOrderImage> {
  File? value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: value == null ? () => showPickerDialog(context) : () {
        showFullScreenImage(context);
      },
      child: SizedBox(
        width: 0.3.sw,
        height: 0.3.sw,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Padding(
              padding: EdgeInsets.all(Style.defaultPadding / 3).copyWith(left: 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
                child: Container(
                  // width: 0.3.sw,
                  // height: 0.3.sw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
                    border: Border.all(
                      color: Theme.of(context).shadowColor,
                      width: 1,
                      strokeAlign: StrokeAlign.inside,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
                    child: value == null ? Center(child: Text('Görsel', textAlign: TextAlign.justify, style: Theme.of(context).textTheme.titleLarge,)) : Image.file(
                      value!,
                      width: 0.3.sw,
                      height: 0.3.sw,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            if (value != null) _buildRemoveBtn(),
          ],
        ),
      ),
    );
  }


  Widget _buildRemoveBtn() {
    return GestureDetector(
      onTap: () {
        _changeValue(null);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Görsel silindi')));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Style.dangerColor,
          borderRadius: BorderRadius.circular(10000),
        ),
        padding: EdgeInsets.all(Style.defaultPadding / 3),
        child: Icon(Icons.clear, color: Colors.white, size: Style.defaultIconSize / 3),
      ),
    );
  }

  void showFullScreenImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return LayoutBuilder(builder: (context, constraints) {
          return Image.file(
            value!,
            width: constraints.maxWidth,
            // height: constraints.minHeight,
            fit: BoxFit.contain,
          );
        });
      },
    );
  }

  showPickerDialog(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () => _pickImage(isCamera: false),
                child: const Text('Galeri'),
              ),
              CupertinoActionSheetAction(
                onPressed: () => _pickImage(isCamera: true),
                child: const Text('Kamera'),
              ),
            ],
          );
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return SolidBottomSheet(
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('Galeri'),
                    leading: const Icon(Icons.image),
                    onTap: () => _pickImage(isCamera: false),
                  ),
                  ListTile(
                    title: const Text('Kamera'),
                    leading: const Icon(Icons.camera_alt),
                    onTap: () => _pickImage(isCamera: true),
                  ),
                ],
              );
            },
          );
        },
      );
    }
  }

  _pickImage({required bool isCamera}) async {
    final image = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (image == null) return;

    _changeValue(File(image.path));
    Navigator.pop(context);
  }

  _changeValue(File? image) {
    setState(() {
      value = image;
      context.read<AddOrderViewModel>().orderModel.image = image;
    });
  }
}
