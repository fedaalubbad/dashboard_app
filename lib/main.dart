import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

//==================== الألوان ====================
class AppColors {
  static const primary = Color(0xFF1E1E2C);
  static const secondary = Color(0xFF2A2A3D);
  static const accent = Color(0xFFFFB74D);
  static const backgroundStart = Color(0xFF2C3E50);
  static const backgroundEnd = Color(0xFF4CA1AF);
  static const text = Colors.white;
}

//==================== MyApp ====================
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Advanced Dashboard",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: ResponsiveDashboard(),
    );
  }
}

//==================== Sidebar ====================
class Sidebar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final bool isCollapsed;

  Sidebar({required this.selectedIndex, required this.onTap, this.isCollapsed = false});

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int hoverIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: widget.isCollapsed ? 70 : 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 50),
          menuItem(Icons.dashboard, "Dashboard", 0),
          menuItem(Icons.person, "Profile", 1),
          menuItem(Icons.settings, "Settings", 2),
        ],
      ),
    );
  }

  Widget menuItem(IconData icon, String title, int index) {
    bool isSelected = widget.selectedIndex == index;
    bool isHovered = hoverIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => hoverIndex = index),
      onExit: (_) => setState(() => hoverIndex = -1),
      child: GestureDetector(
        onTap: () {
          widget.onTap(index); // تحديث selectedIndex
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.accent.withOpacity(0.3)
                : isHovered
                ? Colors.white12
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: isSelected ? AppColors.accent : AppColors.text),
              if (!widget.isCollapsed) ...[
                SizedBox(width: 10),
                Text(title,
                    style: TextStyle(
                        color: isSelected ? AppColors.accent : AppColors.text)),
              ]
            ],
          ),
        ),
      ),
    );
  }}
class AnimatedStatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final int index;

  AnimatedStatsCard(
      {required this.title,
        required this.value,
        required this.icon,
        required this.color,
        required this.index});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 500 + index * 100),
      builder: (context, valueAnimation, child) {
        return Opacity(
          opacity: valueAnimation,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - valueAnimation)),
            child: child,
          ),
        );
      },
      child: StatsCard(title: title, value: value, icon: icon, color: color),
    );
  }
}

//==================== StatsCard ====================
class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  StatsCard(
      {required this.title,
        required this.value,
        required this.icon,
        required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4))],
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: Colors.white),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.white70, fontSize: 16)),
              Text(value,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }
}

class AnimatedLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 800),
      builder: (context, valueAnimation, child) {
        return Opacity(
          opacity: valueAnimation,
          child: Transform.scale(
            scale: valueAnimation,
            child: child,
          ),
        );
      },
      child: LineChartWidget(),
    );
  }
}


//==================== LineChartWidget ====================
class LineChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: true, horizontalInterval: 1),
        titlesData: FlTitlesData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 3),
              FlSpot(1, 2),
              FlSpot(2, 5),
              FlSpot(3, 3.1),
              FlSpot(4, 4),
              FlSpot(5, 3),
              FlSpot(6, 4.5),
            ],
            isCurved: true,
            // colors: [AppColors.accent],
            barWidth: 3,
            dotData: FlDotData(show: true),
          ),
        ],
      ),
    );
  }
}

class AnimatedDataTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 800),
      builder: (context, valueAnimation, child) {
        return Opacity(
          opacity: valueAnimation,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - valueAnimation)),
            child: child,
          ),
        );
      },
      child: SingleChildScrollView(child: DataTableWidget()),
    );
  }
}

//==================== DataTableWidget ====================
class DataTableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('ID', style: TextStyle(color: AppColors.text))),
        DataColumn(label: Text('Name', style: TextStyle(color: AppColors.text))),
        DataColumn(label: Text('Status', style: TextStyle(color: AppColors.text))),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('1', style: TextStyle(color: AppColors.text))),
          DataCell(Text('Alice', style: TextStyle(color: AppColors.text))),
          DataCell(Text('Active', style: TextStyle(color: AppColors.accent))),
        ]),
        DataRow(cells: [
          DataCell(Text('2', style: TextStyle(color: AppColors.text))),
          DataCell(Text('Bob', style: TextStyle(color: AppColors.text))),
          DataCell(Text('Inactive', style: TextStyle(color: Colors.redAccent))),
        ]),
        DataRow(cells: [
          DataCell(Text('3', style: TextStyle(color: AppColors.text))),
          DataCell(Text('Charlie', style: TextStyle(color: AppColors.text))),
          DataCell(Text('Active', style: TextStyle(color: AppColors.accent))),
        ]),
      ],
    );
  }
}

//==================== DashboardContent ====================
class DashboardContent extends StatelessWidget {
  final int selectedIndex;

  DashboardContent({required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position:
            Tween<Offset>(begin: Offset(0.1, 0), end: Offset(0, 0))
                .animate(animation),
            child: child,
          ),
        );
      },
      child: getPage(selectedIndex),
    );
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return LayoutBuilder(
          key: ValueKey(0),
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 600;
            return Container(
              padding: EdgeInsets.all(16),
              color: AppColors.primary,
              child: Column(
                children: [
                  // Animated Cards
                  isMobile
                      ? Column(
                    children: [
                      AnimatedStatsCard(
                          title: "Users",
                          value: "1.2K",
                          icon: Icons.person,
                          color: Colors.blueAccent,
                          index: 0),
                      SizedBox(height: 12),
                      AnimatedStatsCard(
                          title: "Revenue",
                          value: "\$5.4K",
                          icon: Icons.attach_money,
                          color: Colors.green,
                          index: 1),
                      SizedBox(height: 12),
                      AnimatedStatsCard(
                          title: "Orders",
                          value: "320",
                          icon: Icons.shopping_cart,
                          color: Colors.orange,
                          index: 2),
                    ],
                  )
                      : Row(
                    children: [
                      Expanded(
                          child: AnimatedStatsCard(
                              title: "Users",
                              value: "1.2K",
                              icon: Icons.person,
                              color: Colors.blueAccent,
                              index: 0)),
                      SizedBox(width: 12),
                      Expanded(
                          child: AnimatedStatsCard(
                              title: "Revenue",
                              value: "\$5.4K",
                              icon: Icons.attach_money,
                              color: Colors.green,
                              index: 1)),
                      SizedBox(width: 12),
                      Expanded(
                          child: AnimatedStatsCard(
                              title: "Orders",
                              value: "320",
                              icon: Icons.shopping_cart,
                              color: Colors.orange,
                              index: 2)),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Animated Chart
                  SizedBox(height: 250, child: AnimatedLineChart()),
                  SizedBox(height: 20),
                  // Animated Table
                  Expanded(child: AnimatedDataTable()),
                ],
              ),
            );
          },
        );

      case 1:
        return ProfilePage(key: ValueKey(1));

      case 2:
        return Container(
          key: ValueKey(2),
          color: Colors.orangeAccent,
          child: Center(
              child: Text("Settings Page", style: TextStyle(fontSize: 24))),
        );

      default:
        return Container();
    }
  }
}


//==================== ResponsiveDashboard ====================
class ResponsiveDashboard extends StatefulWidget {
  @override
  _ResponsiveDashboardState createState() => _ResponsiveDashboardState();
}

class _ResponsiveDashboardState extends State<ResponsiveDashboard> {
  int selectedIndex = 0;
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 800;

        return Scaffold(
          drawer: isMobile
              ? Drawer(
              child: Sidebar(
                selectedIndex: selectedIndex,
                onTap: (i) {
                  setState(() => selectedIndex = i);
                  Navigator.pop(context);
                },
              ))
              : null,
          body: Row(
            children: [
              if (!isMobile)
                Sidebar(
                  selectedIndex: selectedIndex,
                  onTap: (i) => setState(() => selectedIndex = i),
                  isCollapsed: isCollapsed,
                ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      color: AppColors.primary,
                      child: Row(
                        children: [
                          if (!isMobile)
                            IconButton(
                              icon: Icon(isCollapsed
                                  ? Icons.menu
                                  : Icons.menu_open),
                              color: AppColors.text,
                              onPressed: () =>
                                  setState(() => isCollapsed = !isCollapsed),
                            ),
                          SizedBox(width: 10),
                          Text("Advanced Dashboard",
                              style: TextStyle(
                                  color: AppColors.text, fontSize: 20)),
                        ],
                      ),
                    ),
                    Expanded(child: DashboardContent(selectedIndex: selectedIndex)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      color: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
                "https://i.pravatar.cc/300"), // صورة افتراضية
          ),
          SizedBox(height: 16),
          Text("Fedaa Lubbad", style: TextStyle(fontSize: 26, color: AppColors.text, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("fedaalubbad@example.com", style: TextStyle(fontSize: 16, color: AppColors.text)),
          SizedBox(height: 24),
          Card(
            color: Colors.blueGrey,
            child: ListTile(
              leading: Icon(Icons.phone, color: AppColors.text),
              title: Text("+970 123 456 789", style: TextStyle(color: AppColors.text)),
            ),
          ),
          SizedBox(height: 12),
          Card(
            color: Colors.blueGrey,
            child: ListTile(
              leading: Icon(Icons.location_on, color: AppColors.text),
              title: Text("Gaza, Palestine", style: TextStyle(color: AppColors.text)),
            ),
          ),
        ],
      ),
    );
  }
}
