import 'package:flutter/material.dart';
import '../core/theme/jdonuts_theme.dart';

/// Standalone, static UI gallery based on the J'Donuts code-test designs.
/// No repositories, providers, database, HTTP calls, or persistence.
void main() => runApp(const JDonutsUiPreview());

const _cyan = JDonutsColors.cyan;
const _pink = JDonutsColors.pink;
const _ink = JDonutsColors.ink;

class JDonutsUiPreview extends StatelessWidget {
  const JDonutsUiPreview({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "J'Donuts UI Preview",
    theme: JDonutsTheme.light,
    home: const UiGallery(),
  );
}

class UiGallery extends StatefulWidget {
  const UiGallery({super.key});
  @override
  State<UiGallery> createState() => _UiGalleryState();
}
class _UiGalleryState extends State<UiGallery> {
  int page = 0;
  int quantity = 1;
  int tab = 0;
  final names = const ['Onboarding','Phone number','Verify number','Name (empty)',
    'Name (filled)','Date of birth','Welcome','Home','Product detail','Rewards'];
  void next() => setState(() => page = (page + 1).clamp(0, 9));
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(backgroundColor: Colors.white, title: Text('UI preview • ${names[page]}',
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      actions: [PopupMenuButton<int>(tooltip: 'Choose screen', onSelected: (v) => setState(() => page = v),
        itemBuilder: (_) => List.generate(names.length, (i) => PopupMenuItem(value: i, child: Text('${i+1}. ${names[i]}'))))]),
    body: SafeArea(child: switch (page) {
      0 => _onboarding(),
      1 => _form('Enter your phone\nnumber', ['+95      09264135692'], 1),
      2 => _otp(),
      3 => _form("What's your\nname?", ['First Name','Last Name'], 3),
      4 => _form("What's your\nname?", ['Yo Min','Phyoe Win'], 3),
      5 => _form("What's your\ndate of birth?", ['May','1','1990'], 4),
      6 => _welcome(),
      7 => _home(),
      8 => _product(),
      _ => _rewards(),
    }),
    bottomNavigationBar: page >= 7 ? NavigationBar(selectedIndex: page == 9 ? 1 : 0,
      onDestinationSelected: (i) => setState(() => page = i == 1 ? 9 : 7),
      destinations: const [NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.workspace_premium_outlined), label: 'Reward')]) :
      Padding(padding: const EdgeInsets.all(8), child: Row(children: [
        TextButton(onPressed: page > 0 ? () => setState(() => page--) : null, child: const Text('Previous')),
        const Spacer(), Text('${page+1} / 10'), const Spacer(),
        TextButton(onPressed: page < 9 ? next : null, child: const Text('Next screen'))])),
  );
  Widget _button(String label, VoidCallback action) => SizedBox(width: double.infinity, height: 48,
    child: FilledButton(style: FilledButton.styleFrom(backgroundColor: _cyan, foregroundColor: Colors.white),
      onPressed: action, child: Text(label.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w800))));
  Widget _donut({double size = 100, Color color = const Color(0xFFFF9EBF)}) =>
    Container(width: size, height: size, decoration: BoxDecoration(shape: BoxShape.circle,
      color: color, boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 14, offset: Offset(0, 8))]),
      child: Center(child: Container(width: size * .29, height: size * .29,
        decoration: const BoxDecoration(color: Color(0xFFF9F2EE), shape: BoxShape.circle))));
  Widget _onboarding() => Column(children: [
    Expanded(child: Stack(children: [
      Positioned(top: 30, left: -35, child: _donut(size: 180)),
      Positioned(top: 40, right: -30, child: _donut(size: 135, color: const Color(0xFFB9A3EA))),
      Positioned(bottom: 15, left: 75, child: _donut(size: 160, color: const Color(0xFFEAB66E)))])),
    const Text('Round food for\nevery mood', textAlign: TextAlign.center,
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, height: 1.05)),
    const SizedBox(height: 22),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 30), child: _button("Let's get started", next)),
    TextButton(onPressed: () => setState(() => page = 1), child: const Text('Already have an account? Log in')),
    const Padding(padding: EdgeInsets.all(16), child: Text('●   Google     Apple     Facebook',
      style: TextStyle(color: Colors.black54))), const SizedBox(height: 20),
  ]);
  Widget _form(String heading, List<String> hints, int progress) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        CircularProgressIndicator(value: progress / 4, color: _cyan, backgroundColor: Colors.white),
      ]), const SizedBox(height: 50),
      Text(heading, style: const TextStyle(fontSize: 29, fontWeight: FontWeight.w900, height: 1.1)),
      const SizedBox(height: 24),
      for (final hint in hints) Padding(padding: const EdgeInsets.only(bottom: 12),
        child: TextFormField(initialValue: hint.startsWith('Yo ') || hint == 'Phyoe Win' ? hint : null,
          decoration: InputDecoration(hintText: hint, filled: true, fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none)))),
      const Spacer(), _button('Continue', next), const SizedBox(height: 24),
    ]));
  Widget _otp() => Padding(padding: const EdgeInsets.all(30), child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Align(alignment: Alignment.topRight, child: CircularProgressIndicator(value: .5, color: _cyan)),
      const SizedBox(height: 55), const Text('Verify your number', style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900)),
      const SizedBox(height: 10), const Text('We sent a 6-digit OTP to +959264135692', style: TextStyle(color: Colors.black54)),
      const SizedBox(height: 30), Row(children: List.generate(6, (_) => Expanded(child: Container(
        height: 52, margin: const EdgeInsets.only(right: 6), color: Colors.white)))),
      const SizedBox(height: 14), const Text('Resend in 05:00', style: TextStyle(color: Colors.pink)),
      const Spacer(), _button('Verify', next), const SizedBox(height: 24),
    ]));
  Widget _welcome() => Column(children: [
    Expanded(child: Padding(padding: const EdgeInsets.all(18), child: GridView.count(crossAxisCount: 2,
      mainAxisSpacing: 14, crossAxisSpacing: 14, children: [
        for (final color in [Colors.purpleAccent, Colors.brown, Colors.pinkAccent, Colors.orangeAccent])
          Card(color: color.withValues(alpha: .25), child: Center(child: _donut(size: 115, color: color)))]))),
    const Text("Welcome to the\nworld of J'donuts", textAlign: TextAlign.center,
      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
    Padding(padding: const EdgeInsets.all(24), child: _button("Let's explore", next)),
  ]);
  Widget _productTile(String name, int price, Color color) => SizedBox(width: 155, child: InkWell(
    onTap: () => setState(() => page = 8), child: Card(color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Center(child: _donut(size: 92, color: color))),
        Padding(padding: const EdgeInsets.all(8), child: Text('$name\n$price MMK',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)))]))));
  Widget _section(String title) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900))),
    SizedBox(height: 180, child: ListView(scrollDirection: Axis.horizontal, children: [
      _productTile('Melon Romance Donut', 3200, Colors.pinkAccent),
      _productTile('Strawberry Chocolate', 3200, Colors.brown),
      _productTile('Coconut Donut', 3200, Colors.deepOrangeAccent)]))]);
  Widget _home() => ListView(padding: const EdgeInsets.all(18), children: [
    Row(children: [const CircleAvatar(child: Icon(Icons.person)), const SizedBox(width: 10),
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('Hanla', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
          Text('Silver member • 500 pts to Gold')])),
      IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined))]),
    const SizedBox(height: 15),
    Container(height: 150, decoration: BoxDecoration(color: const Color(0xFF7675C8),
      borderRadius: BorderRadius.circular(14)), child: const Center(child: Text(
      "We're now at\nCentral Boulevard", textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold)))),
    _section('Seasonal specials'), _section('Popular 🔥'), _section('Order again'),
    const SizedBox(height: 20), const Text("There are 4 J'Donut shops near you",
      style: TextStyle(fontWeight: FontWeight.bold)),
    const Card(child: ListTile(title: Text("J'Donuts nearby"), subtitle: Text('Explore now • Order online'))),
  ]);
  Widget _product() => ListView(padding: const EdgeInsets.all(24), children: [
    const Text('Coconut Donut', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900)),
    const Text('JD022123     •     NEW', style: TextStyle(color: Colors.deepOrange)),
    const Text('3,200 MMK', style: TextStyle(fontWeight: FontWeight.bold)),
    const SizedBox(height: 28),
    Container(height: 275, decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(22)), child: Center(child: _donut(size: 210, color: Colors.brown))),
    const SizedBox(height: 16),
    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      IconButton.filledTonal(onPressed: quantity > 1 ? () => setState(() => quantity--) : null,
        icon: const Icon(Icons.remove)), Padding(padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Text('$quantity', style: const TextStyle(fontWeight: FontWeight.bold))),
      IconButton.filledTonal(onPressed: () => setState(() => quantity++), icon: const Icon(Icons.add))]),
    const SizedBox(height: 22), const Text("What's this?", style: TextStyle(fontWeight: FontWeight.w900)),
    const Text('Enjoy our scrumptious coconut donut, with soft dough and a rich chocolate glaze.'),
    const SizedBox(height: 35), _button('Add to cart   ${quantity * 3200} MMK', () {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('UI preview only')));
    }),
  ]);
  Widget _rewards() => ListView(padding: const EdgeInsets.all(20), children: [
    const Row(children: [Expanded(child: Text("J' Donuts Rewards",
      style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900))),
      Chip(label: Text('Rewards 3'))]),
    const SizedBox(height: 30),
    Row(children: [
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ListTile(leading: Icon(Icons.workspace_premium, color: Colors.grey), title: Text('Silver'),
          subtitle: Text("You're here now")),
        ListTile(leading: Icon(Icons.workspace_premium, color: Colors.amber), title: Text('Gold'),
          subtitle: Text('500 pts remaining')),
        ListTile(leading: Icon(Icons.workspace_premium, color: Colors.blueGrey), title: Text('Platinum'),
          subtitle: Text("You'll be here soon"))])),
      Stack(alignment: Alignment.center, children: [
        SizedBox(width: 155, height: 155, child: CircularProgressIndicator(value: .7, strokeWidth: 23,
          color: Colors.pinkAccent, backgroundColor: Colors.white)),
        const Column(children: [Text('Total points', style: TextStyle(color: Colors.pink)),
          Text('680,000', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900))])])]),
    const SizedBox(height: 35),
    SegmentedButton<int>(segments: const [
      ButtonSegment(value: 0, label: Text('Eat more earn more')),
      ButtonSegment(value: 1, label: Text('Gift'))],
      selected: {tab}, onSelectionChanged: (v) => setState(() => tab = v.first)),
    const SizedBox(height: 16),
    if (tab == 0) ...[
      _challenge('Eat 4 Coco donuts', '4/4', Colors.pinkAccent, true),
      _challenge('Eat 4 Coco donuts', '1/4', Colors.grey, false),
      _challenge('Drink 12 cups americano', '9/12', Colors.brown, false),
    ] else const Card(child: Padding(padding: EdgeInsets.all(32), child: Text('Gift rewards'))),
  ]);
  Widget _challenge(String title, String progress, Color color, bool ready) => Card(
    color: Colors.white, margin: const EdgeInsets.only(bottom: 14), child: Padding(
      padding: const EdgeInsets.all(14), child: Row(children: [
        _donut(size: 80, color: color), const SizedBox(width: 16),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(progress), const SizedBox(height: 8),
          FilledButton(onPressed: () {}, style: FilledButton.styleFrom(
            backgroundColor: ready ? _cyan : Colors.grey.shade300),
            child: const Text('EARN'))])),
        const Text('100 pts', style: TextStyle(fontSize: 11))])));
}
