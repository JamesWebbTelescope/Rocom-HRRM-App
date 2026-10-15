import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

 class Task {
    final String taskId;
    final String description;
    final String requiredCapability;
    final int priority;
    final String status;
    final String assignedAgentId;
    final String zone;
    final Map<String, dynamic> constraints;
    final String createdAt;
    final String updatedAt;


    const Task({required this.taskId, required this.description, required this.requiredCapability, required this.priority, required this.status, required this.assignedAgentId, required this.zone, required this.constraints, required this.createdAt, required this.updatedAt});

    Map<String, dynamic> toJson() => {
      'taskId': taskId,
      'description': description,
      'requiredCapability': requiredCapability,
      'priority': priority,
      'status': status,
      'assignedAgentId': assignedAgentId,
      'zone': zone,
      'constraints': constraints,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };

    factory Task.fromJson(Map<String, dynamic> json) {
      debugPrint('🔍 Parsing JSON: $json');
      try {
        final constraintsRaw = json['constraints'];
        final Map<String, dynamic> constraints = constraintsRaw is Map
            ? Map<String, dynamic>.from(constraintsRaw)
            : {};
        
        return Task(
          taskId: _safeToString(json['taskId']),
          description: _safeToString(json['description']),
          requiredCapability: _safeToString(json['requiredCapability']),
          priority: _safeToInt(json['priority']),
          status: _safeToString(json['status']),
          assignedAgentId: _safeToString(json['assignedAgentId']),
          zone: _safeToString(json['zone']),
          constraints: constraints,
          createdAt: _safeToString(json['createdAt']),
          updatedAt: _safeToString(json['updatedAt']),
        );
      } catch (e) {
        debugPrint('❌ Invalid JSON structure. Got: $json');
        debugPrint('❌ Error: $e');
        throw const FormatException('Failed to load tasks.');
      }
    }

    static String _safeToString(dynamic value) {
      if (value == null) return '';
      return value.toString();
    }

    static int _safeToInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    static Future<List<Task>> fetchTasks() async {
      debugPrint('📡 Fetching tasks from: http://192.168.111.3:18830/tasks');
      final response = await http.get(
        Uri.parse('http://192.168.111.3:18830/tasks'),
        headers: {'Accept': 'application/json'},
      );

      debugPrint('📥 Response status: ${response.statusCode}');
      debugPrint('📥 Response body: ${response.body}');

      if (response.statusCode == 200) {
        debugPrint('✅ Parsing JSON...');
        return (jsonDecode(response.body) as List).map((json) => Task.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        debugPrint('❌ Request failed with status: ${response.statusCode}');
        throw Exception('Failed to load tasks: HTTP ${response.statusCode}');
      }
    }
    static Future<List<Task>> sendTasks() async {
      debugPrint('📡 Sending task to: http://192.168.111.3:18830/tasks');
      final task = Task(
        taskId: '',
        description: 'Sample Task',
        requiredCapability: 'delivery.meal',
        priority: 1,
        status: 'pending',
        assignedAgentId: 'agent-001',
        zone: 'zone-001',
        constraints: {'max_weight_kg': 10},
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      );
      final response = await http.post(
        Uri.parse('http://10.0.6.209:18830/tasks'),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        body: jsonEncode(task.toJson()),
      );

      debugPrint('📥 Response status: ${response.statusCode}');
      debugPrint('📥 Response body: ${response.body}');

      if (response.statusCode == 201) {
        debugPrint('✅ Task created successfully. Parsing JSON...');
        return [Task.fromJson(jsonDecode(response.body) as Map<String, dynamic>)];
      } else {
        debugPrint('❌ Request failed with status: ${response.statusCode}');
        throw Exception('Failed to create task: HTTP ${response.statusCode}');
      }
    }
    static Future<Task> createTask(String description, int priority) async {
      debugPrint('📡 Sending task to: http://192.168.111.3:18830/tasks');
      final task = Task(
        taskId: '',
        description: description,
        requiredCapability: 'delivery.meal',
        priority: priority,
        status: 'pending',
        assignedAgentId: 'agent-001',
        zone: 'zone-001',
        constraints: {'max_weight_kg': 10},
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      );
      final response = await http.post(
        Uri.parse('http://10.0.6.209:18830/tasks'),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        body: jsonEncode(task.toJson()),
      );

      debugPrint('📥 Response status: ${response.statusCode}');
      debugPrint('📥 Response body: ${response.body}');

      if (response.statusCode == 201) {
        debugPrint('✅ Task created successfully. Parsing JSON...');
        return Task.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        debugPrint('❌ Request failed with status: ${response.statusCode}');
        throw Exception('Failed to create task: HTTP ${response.statusCode}');
      }
    }
 }

 class Agent {
    final String type;
    final String hrRef;
    final String agentId;
    final String status;
    final List<String> capabilities;
    final Map<String, dynamic> position;
    final Map<String, dynamic> metadata;

    const Agent({
      required this.type,
      required this.hrRef,
      required this.agentId,
      required this.status,
      required this.capabilities,
      required this.position,
      required this.metadata,
    });

    Map<String, dynamic> toJson() => {
      'type': type,
      'hrRef': hrRef,
      'agentId': agentId,
      'status': status,
      'capabilities': capabilities,
      'position': position,
      'metadata': metadata,
    };

    factory Agent.fromJson(Map<String, dynamic> json) {
      return Agent(
        type: json['type'] as String? ?? '',
        hrRef: json['hrRef'] as String? ?? '',
        agentId: json['agentId'] as String? ?? '',
        status: json['status'] as String? ?? '',
        capabilities: (json['capabilities'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
        position: json['position'] as Map<String, dynamic>? ?? {},
        metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      );
    }
 }

void main() {
  debugPrint('🚀 App starting...');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocom HRRM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      home: const MyHomePage(title: 'Rocom HRRM Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _showTaskForm = false;
  String _taskDescription = '';
  int _taskPriority = 1;
  bool _showAgentForm = false;
  String _agentType = '';
  String _agentStatus = '';
  late Future<List<Task>> futureTasks;

  @override
  void initState() {
    super.initState();
    debugPrint('🏠 MyHomePage initState');
    _refreshTasks();
  }

  void _refreshTasks() {
    debugPrint('🔄 Refreshing tasks...');
    setState(() {
      futureTasks = Task.fetchTasks();
    });
  }

  void _incrementCounter() {
    debugPrint('➕ Counter incremented from $_counter to ${_counter + 1}');
    setState(() {
      _counter++;
    });
  }

  void _toggleTaskForm() {
    setState(() {
      _showTaskForm = !_showTaskForm;
    });
  }

  void _toggleAgentForm() {
    setState(() {
      _showAgentForm = !_showAgentForm;
    });
  }

  Future<void> _sendNewTask() async {
    debugPrint('📤 Sending new task with description: $_taskDescription, priority: $_taskPriority');
    try {
      await Task.createTask(_taskDescription, _taskPriority);
      setState(() {
        _taskDescription = '';
        _taskPriority = 1;
        _showTaskForm = false;
      });
    } catch (e) {
      debugPrint('❌ Failed to send task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _refreshTasks,
                  child: const Text('Refresh Tasks'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _toggleTaskForm,
                  child: const Text('New task'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _toggleAgentForm,
                  child: const Text('Add Agent'),
                ),
              ],
            ),
            if (_showTaskForm) ...[
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Text(
                      'Create New Task',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _taskDescription = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Priority',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _taskPriority = int.tryParse(value) ?? 1;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _sendNewTask,
                      child: const Text('Send task'),
                    ),
                  ],
                ),
              ),
            ],
            if (_showAgentForm) ...[
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Text(
                      'Create New Agent',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Type',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _agentType = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _agentStatus = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Create Agent'),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class GetTaskContent extends StatefulWidget {
  const GetTaskContent({super.key});

  @override
  State<GetTaskContent> createState() => _GetTaskContentState();
}

class _GetTaskContentState extends State<GetTaskContent> {
  late Future<List<Task>> futureTasks;

  @override
  void initState() {
    super.initState();
    debugPrint('🛠️  InitState: Fetching tasks');
    futureTasks = Task.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: futureTasks,
      builder: (context, snapshot) {
        debugPrint('🔄 FutureBuilder state: ${snapshot.connectionState}');
        if (snapshot.hasData) {
          debugPrint('✅ Tasks loaded: ${snapshot.data}');
          final tasks = snapshot.data!;
          return Column(
            children: tasks.map((task) => Text(task.description)).toList()
          );
        } else if (snapshot.hasError) {
          debugPrint('❌ Tasks error: ${snapshot.error}');
          debugPrint('❌ Stack trace: ${snapshot.stackTrace}');
          return Text('Error: ${snapshot.error}\nStack: ${snapshot.stackTrace}');
        }
        debugPrint('⏳ Waiting for tasks data...');
        return const CircularProgressIndicator();
      },
    );
  }
}

class GetTask extends StatefulWidget {
  const GetTask({super.key});

  @override
  State<GetTask> createState() => _GetTaskState();
}

class _GetTaskState extends State<GetTask> {
  @override
  Widget build(BuildContext context) {
    return const GetTaskContent();
  }
}
