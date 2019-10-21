import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData.dark(),
            home: MyHomePage(title: 'Light Game'),
        );
    }
}

class MyHomePage extends StatefulWidget {
    MyHomePage({Key key, this.title}) : super(key: key);
    final String title;
    
    @override
    _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
    Random r = Random();
    int _count = 3;
    double _c = 3;
    List<bool> light = List<bool>();
    
    @override
    void initState() {
        super.initState();
        _generateLight(_count * _count);
    }
    
    void _generateLight(int count) {
        for (int a = 0; a < count; a++) {
            light.add(r.nextInt(900) == 0);
        }
    }
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
                appBar: AppBar(
                    title: Text(widget.title),
                ),
                body: Center(
                    child: Column(
                        children: <Widget>[
                            Slider(
                                min: 1,
                                max: 8,
                                divisions: 7,
                                value: _c,
                                onChanged: (value) {
                                    setState(() {
                                        _c = value;
                                        _count = _c.round();
                                        light.clear();
                                        _generateLight(_count * _count);
                                    });
                                },
                            ),
                            Expanded(
                                child: GridView.count(
                                    crossAxisCount: _count,
                                    children: List.generate(_count * _count, (index) {
                                        return _light(index);
                                    }),
                                ),
                            ),
                        ],
                    ),
                )
        );
    }
    
    Widget _light(int index) {
        List<int> neigh = List<int>();
        neigh.add(index);
        if (index % _count != 0) neigh.add(index - 1);
        if (index % _count != _count - 1) neigh.add(index + 1);
        if (index >= _count) neigh.add(index - _count);
        if (index < _count * (_count - 1)) neigh.add(index + _count);
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: light[index] ? Colors.amberAccent : Colors.black54,
                child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    highlightColor: Colors.white30,
                    onTap: () => setState(() => neigh.forEach((n) => light[n] = !light[n])),
                ),
            ),
        );
    }
}
