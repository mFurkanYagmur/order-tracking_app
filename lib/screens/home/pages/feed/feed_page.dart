import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:order_tracking_app/constants/extensions.dart';
import 'package:order_tracking_app/constants/style.dart';
import 'package:order_tracking_app/model/order_model.dart';
import 'package:order_tracking_app/screens/home/pages/feed/components/weekly_calender_tabview.dart';
import 'package:order_tracking_app/view_models/order_viewmodel.dart';
import 'package:order_tracking_app/widgets/order_list/order_list_item.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatefulWidget {
  FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int? selectedIndex;
  /*final List<List<OrderModel>> orderList = [
    [
      OrderModel(
        'ngksdngskdpgn',
        'Müşteri 1',
        321,
        123,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean placerat interdum luctus. Duis ultrices eros turpis, vitae accumsan ex aliquet quis. Etiam vitae nibh ultrices, consequat ante eget, dignissim nisl. Integer scelerisque odio ut enim feugiat, a vestibulum quam suscipit. Pellentesque ut leo ligula. Etiam sit amet orci sed sem accumsan ullamcorper vel a tellus. Duis gravida diam odio, ac egestas ipsum dignissim vitae.',
        '05379705982',
        ['https://picsum.photos/500/800'],
        'yagmurfurkan425@gmail.com',
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
        '1f23sadg5a6h5fsda6',
        OrderStatus(2),
      ),
      OrderModel(
        'ngksdngskdpgn',
        'Müşteri 1',
        321,
        123,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean placerat interdum luctus. Duis ultrices eros turpis, vitae accumsan ex aliquet quis. Etiam vitae nibh ultrices, consequat ante eget, dignissim nisl. Integer scelerisque odio ut enim feugiat, a vestibulum quam suscipit. Pellentesque ut leo ligula. Etiam sit amet orci sed sem accumsan ullamcorper vel a tellus. Duis gravida diam odio, ac egestas ipsum dignissim vitae.',
        '05379705982',
        ['https://picsum.photos/500/800'],
        'yagmurfurkan425@gmail.com',
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
        '1f23sadg5a6h5fsda6',
        OrderStatus(2),
      ),
      OrderModel(
        'ngksdngskdpgn',
        'Müşteri 1',
        321,
        123,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean placerat interdum luctus. Duis ultrices eros turpis, vitae accumsan ex aliquet quis. Etiam vitae nibh ultrices, consequat ante eget, dignissim nisl. Integer scelerisque odio ut enim feugiat, a vestibulum quam suscipit. Pellentesque ut leo ligula. Etiam sit amet orci sed sem accumsan ullamcorper vel a tellus. Duis gravida diam odio, ac egestas ipsum dignissim vitae.',
        '05379705982',
        ['https://picsum.photos/500/800'],
        'yagmurfurkan425@gmail.com',
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
        '1f23sadg5a6h5fsda6',
        OrderStatus(2),
      ),
      OrderModel(
        'ngksdngskdpgn',
        'Müşteri 1',
        321,
        123,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean placerat interdum luctus. Duis ultrices eros turpis, vitae accumsan ex aliquet quis. Etiam vitae nibh ultrices, consequat ante eget, dignissim nisl. Integer scelerisque odio ut enim feugiat, a vestibulum quam suscipit. Pellentesque ut leo ligula. Etiam sit amet orci sed sem accumsan ullamcorper vel a tellus. Duis gravida diam odio, ac egestas ipsum dignissim vitae.',
        '05379705982',
        ['https://picsum.photos/500/800'],
        'yagmurfurkan425@gmail.com',
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
        '1f23sadg5a6h5fsda6',
        OrderStatus(2),
      ),
      OrderModel(
        'ngksdngskdpgn',
        'Müşteri 2',
        321,
        123,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean placerat interdum luctus. Duis ultrices eros turpis, vitae accumsan ex aliquet quis. Etiam vitae nibh ultrices, consequat ante eget, dignissim nisl. Integer scelerisque odio ut enim feugiat, a vestibulum quam suscipit. Pellentesque ut leo ligula. Etiam sit amet orci sed sem accumsan ullamcorper vel a tellus. Duis gravida diam odio, ac egestas ipsum dignissim vitae.',
        '05379705982',
        ['https://picsum.photos/500/800'],
        'yagmurfurkan425@gmail.com',
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
        '1f23sadg5a6h5fsda6',
        OrderStatus(2),
      ),
      OrderModel(
        'ngksdngskdpgn',
        'Müşteri 3',
        321,
        123,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean placerat interdum luctus. Duis ultrices eros turpis, vitae accumsan ex aliquet quis. Etiam vitae nibh ultrices, consequat ante eget, dignissim nisl. Integer scelerisque odio ut enim feugiat, a vestibulum quam suscipit. Pellentesque ut leo ligula. Etiam sit amet orci sed sem accumsan ullamcorper vel a tellus. Duis gravida diam odio, ac egestas ipsum dignissim vitae.',
        '05379705982',
        ['https://picsum.photos/500/800'],
        'yagmurfurkan425@gmail.com',
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
        '1f23sadg5a6h5fsda6',
        OrderStatus(2),
      ),
      OrderModel(
        'ngksdngskdpgn',
        'Müşteri 3',
        321,
        123,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean placerat interdum luctus. Duis ultrices eros turpis, vitae accumsan ex aliquet quis. Etiam vitae nibh ultrices, consequat ante eget, dignissim nisl. Integer scelerisque odio ut enim feugiat, a vestibulum quam suscipit. Pellentesque ut leo ligula. Etiam sit amet orci sed sem accumsan ullamcorper vel a tellus. Duis gravida diam odio, ac egestas ipsum dignissim vitae.',
        '05379705982',
        ['https://picsum.photos/500/800'],
        'yagmurfurkan425@gmail.com',
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
        '1f23sadg5a6h5fsda6',
        OrderStatus(2),
      ),
      OrderModel(
        'ngksdngskdpgn',
        'Müşteri 3',
        321,
        123,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean placerat interdum luctus. Duis ultrices eros turpis, vitae accumsan ex aliquet quis. Etiam vitae nibh ultrices, consequat ante eget, dignissim nisl. Integer scelerisque odio ut enim feugiat, a vestibulum quam suscipit. Pellentesque ut leo ligula. Etiam sit amet orci sed sem accumsan ullamcorper vel a tellus. Duis gravida diam odio, ac egestas ipsum dignissim vitae.',
        '05379705982',
        ['https://picsum.photos/500/800'],
        'yagmurfurkan425@gmail.com',
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
        '1f23sadg5a6h5fsda6',
        OrderStatus(2),
      ),
      OrderModel(
        'ngksdngskdpgn',
        'Müşteri 3',
        321,
        123,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean placerat interdum luctus. Duis ultrices eros turpis, vitae accumsan ex aliquet quis. Etiam vitae nibh ultrices, consequat ante eget, dignissim nisl. Integer scelerisque odio ut enim feugiat, a vestibulum quam suscipit. Pellentesque ut leo ligula. Etiam sit amet orci sed sem accumsan ullamcorper vel a tellus. Duis gravida diam odio, ac egestas ipsum dignissim vitae.',
        '05379705982',
        ['https://picsum.photos/500/800'],
        'yagmurfurkan425@gmail.com',
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
        '1f23sadg5a6h5fsda6',
        OrderStatus(2),
      ),
      OrderModel(
        'ngksdngskdpgn',
        'Müşteri 4',
        321,
        123,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean placerat interdum luctus. Duis ultrices eros turpis, vitae accumsan ex aliquet quis. Etiam vitae nibh ultrices, consequat ante eget, dignissim nisl. Integer scelerisque odio ut enim feugiat, a vestibulum quam suscipit. Pellentesque ut leo ligula. Etiam sit amet orci sed sem accumsan ullamcorper vel a tellus. Duis gravida diam odio, ac egestas ipsum dignissim vitae.',
        '05379705982',
        ['https://picsum.photos/500/800'],
        'yagmurfurkan425@gmail.com',
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
        '1f23sadg5a6h5fsda6',
        OrderStatus(2),
      ),
    ],
    [
      OrderModel(
        'ngksdngskdpgn',
        'Müşteri 5',
        321,
        123,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean placerat interdum luctus. Duis ultrices eros turpis, vitae accumsan ex aliquet quis. Etiam vitae nibh ultrices, consequat ante eget, dignissim nisl. Integer scelerisque odio ut enim feugiat, a vestibulum quam suscipit. Pellentesque ut leo ligula. Etiam sit amet orci sed sem accumsan ullamcorper vel a tellus. Duis gravida diam odio, ac egestas ipsum dignissim vitae.',
        '05379705982',
        ['https://picsum.photos/500/800'],
        'yagmurfurkan425@gmail.com',
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
        '1f23sadg5a6h5fsda6',
        OrderStatus(2),
      ),
      OrderModel(
        'ngksdngskdpgn',
        'Müşteri 6',
        321,
        123,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean placerat interdum luctus. Duis ultrices eros turpis, vitae accumsan ex aliquet quis. Etiam vitae nibh ultrices, consequat ante eget, dignissim nisl. Integer scelerisque odio ut enim feugiat, a vestibulum quam suscipit. Pellentesque ut leo ligula. Etiam sit amet orci sed sem accumsan ullamcorper vel a tellus. Duis gravida diam odio, ac egestas ipsum dignissim vitae.',
        '05379705982',
        ['https://picsum.photos/500/800'],
        'yagmurfurkan425@gmail.com',
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
        '1f23sadg5a6h5fsda6',
        OrderStatus(2),
      ),
    ],
    [
      OrderModel(
        'ngksdngskdpgn',
        'Müşteri 7',
        321,
        123,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean placerat interdum luctus. Duis ultrices eros turpis, vitae accumsan ex aliquet quis. Etiam vitae nibh ultrices, consequat ante eget, dignissim nisl. Integer scelerisque odio ut enim feugiat, a vestibulum quam suscipit. Pellentesque ut leo ligula. Etiam sit amet orci sed sem accumsan ullamcorper vel a tellus. Duis gravida diam odio, ac egestas ipsum dignissim vitae.',
        '05379705982',
        ['https://picsum.photos/500/800'],
        'yagmurfurkan425@gmail.com',
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
        '1f23sadg5a6h5fsda6',
        OrderStatus(2),
      ),
      OrderModel(
        'ngksdngskdpgn',
        'Müşteri 8',
        321,
        123,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean placerat interdum luctus. Duis ultrices eros turpis, vitae accumsan ex aliquet quis. Etiam vitae nibh ultrices, consequat ante eget, dignissim nisl. Integer scelerisque odio ut enim feugiat, a vestibulum quam suscipit. Pellentesque ut leo ligula. Etiam sit amet orci sed sem accumsan ullamcorper vel a tellus. Duis gravida diam odio, ac egestas ipsum dignissim vitae.',
        '05379705982',
        ['https://picsum.photos/500/800'],
        'yagmurfurkan425@gmail.com',
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
        '1f23sadg5a6h5fsda6',
        OrderStatus(2),
      ),
      OrderModel(
        'ngksdngskdpgn',
        'Müşteri 9',
        321,
        123,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean placerat interdum luctus. Duis ultrices eros turpis, vitae accumsan ex aliquet quis. Etiam vitae nibh ultrices, consequat ante eget, dignissim nisl. Integer scelerisque odio ut enim feugiat, a vestibulum quam suscipit. Pellentesque ut leo ligula. Etiam sit amet orci sed sem accumsan ullamcorper vel a tellus. Duis gravida diam odio, ac egestas ipsum dignissim vitae.',
        '05379705982',
        ['https://picsum.photos/500/800'],
        'yagmurfurkan425@gmail.com',
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
        '1f23sadg5a6h5fsda6',
        OrderStatus(2),
      ),
    ],
    [
      OrderModel(
        'ngksdngskdpgn',
        'Müşteri 10',
        321,
        123,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean placerat interdum luctus. Duis ultrices eros turpis, vitae accumsan ex aliquet quis. Etiam vitae nibh ultrices, consequat ante eget, dignissim nisl. Integer scelerisque odio ut enim feugiat, a vestibulum quam suscipit. Pellentesque ut leo ligula. Etiam sit amet orci sed sem accumsan ullamcorper vel a tellus. Duis gravida diam odio, ac egestas ipsum dignissim vitae.',
        '05379705982',
        ['https://picsum.photos/500/800'],
        'yagmurfurkan425@gmail.com',
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
        '1f23sadg5a6h5fsda6',
        OrderStatus(2),
      ),
    ],
    [
      OrderModel(
        'ngksdngskdpgn',
        'Müşteri 11',
        321,
        123,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean placerat interdum luctus. Duis ultrices eros turpis, vitae accumsan ex aliquet quis. Etiam vitae nibh ultrices, consequat ante eget, dignissim nisl. Integer scelerisque odio ut enim feugiat, a vestibulum quam suscipit. Pellentesque ut leo ligula. Etiam sit amet orci sed sem accumsan ullamcorper vel a tellus. Duis gravida diam odio, ac egestas ipsum dignissim vitae.',
        '05379705982',
        ['https://picsum.photos/500/800'],
        'yagmurfurkan425@gmail.com',
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
        '1f23sadg5a6h5fsda6',
        OrderStatus(2),
      ),
    ],
    [],
    [
      OrderModel(
        'ngksdngskdpgn',
        'Müşteri 12',
        321,
        123,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean placerat interdum luctus. Duis ultrices eros turpis, vitae accumsan ex aliquet quis. Etiam vitae nibh ultrices, consequat ante eget, dignissim nisl. Integer scelerisque odio ut enim feugiat, a vestibulum quam suscipit. Pellentesque ut leo ligula. Etiam sit amet orci sed sem accumsan ullamcorper vel a tellus. Duis gravida diam odio, ac egestas ipsum dignissim vitae.',
        '05379705982',
        ['https://picsum.photos/500/800'],
        'yagmurfurkan425@gmail.com',
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
        '1f23sadg5a6h5fsda6',
        OrderStatus(2),
      ),
      OrderModel(
        'ngksdngskdpgn',
        'Müşteri 13',
        321,
        123,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean placerat interdum luctus. Duis ultrices eros turpis, vitae accumsan ex aliquet quis. Etiam vitae nibh ultrices, consequat ante eget, dignissim nisl. Integer scelerisque odio ut enim feugiat, a vestibulum quam suscipit. Pellentesque ut leo ligula. Etiam sit amet orci sed sem accumsan ullamcorper vel a tellus. Duis gravida diam odio, ac egestas ipsum dignissim vitae.',
        '05379705982',
        ['https://picsum.photos/500/800'],
        'yagmurfurkan425@gmail.com',
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
        '1f23sadg5a6h5fsda6',
        OrderStatus(2),
      ),
    ],
  ];*/
  final DateTime nowDate = DateTime.now();

  double? titleHeight;
  OrderViewModel? _orderViewModel;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await _orderViewModel!.fetchOrderList();
      setState(() {

      });
    });

  }

  @override
  Widget build(BuildContext context) {
    _orderViewModel ??= context.read<OrderViewModel>();
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildtitle(context),
          _buildWeeklyCalendar(),
          (_orderViewModel!.orderList[DateTime.now().toFormattedString()] == null) ?
            const CircularProgressIndicator() :
          _buildOrderList(_orderViewModel!.orderList[DateTime.now().toFormattedString()]!/*orderList[selectedIndex ?? nowDate.weekday - 1]*/),
        ],
      ),
    );
  }

  Widget _buildWeeklyCalendar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Style.defaultPadding),
      child: WeeklyCalender(
          indexDay: nowDate,
          onDayChanged: (index) {
            setState(() {
              selectedIndex = index;
            });
          }),
    );
  }

  Widget _buildOrderList(List<OrderModel> orderList) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Style.defaultPadding * 0.4, vertical: Style.defaultPadding / 2),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: Style.defaultPadding * 0.2),
            child: OrderListItem(order: orderList[index]),
          );
        },
        itemCount: orderList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );

    /*return ListView.separated(itemBuilder: (context, index) {
      return OrderListItem(order: orderList[index]);
    }, separatorBuilder: (context, index){
      return SizedBox();//SizedBox(height: Style.defaultPadding*0.5,);
    }, itemCount: orderList.length, shrinkWrap: true, physics: NeverScrollableScrollPhysics(),);*/
  }

  Widget _buildMonthlyCalendarBtn() {
    /*return IconButton(
      onPressed: () {},
      iconSize: Style.defaultIconSize,
      style: IconButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: Style.secondaryColor,
        foregroundColor: Style.secondaryColor,
      ),
      color: Style.secondaryColor,
      icon: SvgPicture.asset(
        'assets/icons/calendar_month.svg',
        color: Theme.of(context).iconTheme.color,
        // height: Style.defaultIconSize*0.75,
        // width: Style.defaultIconSize*0.75,
      ),
    );*/
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(Style.defaultPadding / 2),
        // height: Style.defaultIconSize*1.2,
        // width: Style.defaultIconSize*1.2,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Style.secondaryColor,
        ),
        child: SvgPicture.asset(
          'assets/icons/calendar_month.svg',
          color: Colors.white,
          height: Style.defaultIconSize * 0.75,
          width: Style.defaultIconSize * 0.75,
        ),
      ),
    );
  }

  Widget _buildtitle(context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Style.defaultPadding, horizontal: Style.defaultPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildMenuBtn(context),
          _buildTitleContent(context),
          _buildMonthlyCalendarBtn(),
        ],
      ),
    );
  }

  Widget _buildTitleContent(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '12 Mart',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(
          height: Style.defaultPadding * 0.25,
        ),
        Text(
          '9 Sipariş Alındı',
          style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Theme.of(context).hintColor),
        ),
      ],
    );
  }

  Widget _buildMenuBtn(context) {
    return IconButton(
      onPressed: () {},
      iconSize: Style.defaultIconSize / 2,
      icon: SvgPicture.asset(
        'assets/icons/menu-burger.svg',
        color: Style.secondaryColor,
      ),
    );
  }
}
