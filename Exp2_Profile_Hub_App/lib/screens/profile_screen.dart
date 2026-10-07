import 'package:flutter/material.dart';
import '../widgets/skill_chip.dart';
import '../widgets/contact_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Portfolio'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header Card with Profile Image and Info
              Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Profile Image
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 3.0,
                          ),
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      
                      // Name
                      const Text(
                        'Dev Radia',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      
                      // Role & Qualification
                      Text(
                        'Full-Stack & Mobile Developer',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      const Text(
                        'B.Tech in Computer Science and Engineering',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Divider(height: 24.0),

                      // Quick Stats Row demonstrating Flexible & Expanded
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: const [
                                Text(
                                  '10+',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 2.0),
                                Text(
                                  'Projects',
                                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: Column(
                              children: const [
                                Text(
                                  '100%',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 2.0),
                                Text(
                                  'Commitment',
                                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20.0),

              // Skills Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Technical Skills',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 10.0),

              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: const [
                  SkillChip(skillName: 'Flutter', icon: Icons.phone_android),
                  SkillChip(skillName: 'Dart', icon: Icons.code),
                  SkillChip(skillName: 'Python', icon: Icons.terminal),
                  SkillChip(skillName: 'FastAPI', icon: Icons.api),
                  SkillChip(skillName: 'Git & GitHub', icon: Icons.merge_type),
                  SkillChip(skillName: 'SQL Databases', icon: Icons.storage),
                ],
              ),

              const SizedBox(height: 24.0),

              // Contact Information Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Contact Information',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 8.0),

              const ContactTile(
                icon: Icons.email_outlined,
                title: 'Email Address',
                value: 'dev.radia@example.com',
              ),
              const ContactTile(
                icon: Icons.phone_outlined,
                title: 'Phone Number',
                value: '+91 98765 43210',
              ),
              const ContactTile(
                icon: Icons.location_on_outlined,
                title: 'Location',
                value: 'Rajkot, Gujarat, India',
              ),
              const ContactTile(
                icon: Icons.link,
                title: 'GitHub',
                value: 'github.com/devradia',
              ),
            ],
          ),
        ),
      ),
    );
  }
}