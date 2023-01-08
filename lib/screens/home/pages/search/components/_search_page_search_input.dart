part of '../search_page.dart';

class _SearchPageSearchInput extends StatefulWidget {
  const _SearchPageSearchInput({Key? key, required this.cardHeight}) : super(key: key);

  final double cardHeight;

  @override
  State<_SearchPageSearchInput> createState() => _SearchPageSearchInputState();
}

class _SearchPageSearchInputState extends State<_SearchPageSearchInput> {
  bool isExtended = false;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10000),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSize(
            duration: const Duration(milliseconds: 100),
            child: (!isExtended)
                ? const SizedBox()
                : Row(
                    children: [
                      Center(
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  isExtended = false;
                                });
                              },
                              icon: Icon(
                                Icons.clear,
                                size: Style.defaultIconSize / 2,
                                color: Theme.of(context).hintColor,
                              ))),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 0.3.sw),
                        child: _buildTextField(),
                      ),
                    ],
                  ),
          ),
          SizedBox(
              height: widget.cardHeight,
              width: widget.cardHeight,
              child: IconButton(
                  onPressed: () {
                    if (!isExtended) {
                      setState(() {
                        isExtended = true;
                      });
                    } else {
                      _search();
                    }
                  },
                  icon: Icon(
                    Icons.search,
                    size: Style.defaultIconSize * 0.75,
                  ))),
        ],
      ),
    );
  }

  TextFormField _buildTextField() {
    return TextFormField(
      controller: _textController,
      onFieldSubmitted: (s) => _search(),
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Anahtar kelime',
      ),
      textInputAction: TextInputAction.search,
    );
  }

  _search() {
    try {
      var provider = context.read<OrderViewModel>();
      provider.searchString = _textController.text;
      provider.fetchOrderList();
    } catch (e) {
      debugPrint('"searchPageSearchInput" ERROR: $e');
    }
  }
}
