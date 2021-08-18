import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../services/email_api.dart';
import '../../../../Theme/my_text_theme.dart';

final _formKey = GlobalKey<FormState>();

class ContributeModal extends StatelessWidget {
  const ContributeModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final TextEditingController subjectController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    Widget makeDismissable({required Widget child}) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.pop(context),
          child: child,
        );

    return size.width < 550
        ? makeDismissable(
            child: DraggableScrollableSheet(
                initialChildSize: 0.15,
                maxChildSize: 1.4,
                minChildSize: 0.08,
                builder: (_, controller) => DesktopContributeModal(
                    scrollController: controller,
                    size: size,
                    subjectController: subjectController,
                    emailController: emailController,
                    nameController: nameController,
                    messageController: messageController)),
          )
        : DesktopContributeModal(
            scrollController: ScrollController(),
            size: size,
            subjectController: subjectController,
            emailController: emailController,
            nameController: nameController,
            messageController: messageController);
  }
}

// desktop modal bottom sheet

class DesktopContributeModal extends StatelessWidget {
  const DesktopContributeModal({
    Key? key,
    required this.size,
    required this.subjectController,
    required this.emailController,
    required this.nameController,
    required this.messageController,
    required this.scrollController,
  }) : super(key: key);

  final Size size;
  final TextEditingController subjectController;
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController messageController;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    bool validate() {
      bool status = false;
      final form = _formKey.currentState;
      if (form!.validate()) {
        form.save();
        status = true;
      } else {
        status = false;
      }
      return status;
    }

    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          color: Colors.white),
      margin: EdgeInsets.only(
        right: size.width < 550 ? 0 : size.width * 1 / 6 - 20,
        left: size.width < 550 ? 0 : size.width * (4 / 9 + 1 / 6) - 20,
      ),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 3,
              width: 36,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6), color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            Opacity(
              opacity: 0.6,
              child: SvgPicture.asset(
                'assets/images/contribution.svg',
                height: 100,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Yuk ikut berkontribusi!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Isi form di bawah ini untuk agar kami bisa menghubungimu! Patikan diisi dengan benar ya.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    style: MyTextTheme.inputStyle,
                    validator: (String? value) =>
                        value == '' ? "Perihal harus diisi" : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: subjectController,
                    decoration: const InputDecoration(
                        labelStyle: MyTextTheme.labelStyle,
                        hintStyle: MyTextTheme.hintStyle,
                        prefixIcon: Icon(
                          Icons.message,
                          size: 16,
                        ),
                        labelText: "Perihal",
                        hintText:
                            "Saya ingin mengupload artikel tentang covid-19",
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                  ),
                  TextFormField(
                    style: MyTextTheme.inputStyle,
                    validator: (String? value) => !value!.contains('@')
                        ? "Email salah, input email yang benar"
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    decoration: const InputDecoration(
                        labelStyle: MyTextTheme.labelStyle,
                        hintStyle: MyTextTheme.hintStyle,
                        prefixIcon: Icon(
                          Icons.email,
                          size: 16,
                        ),
                        labelText: "Email",
                        hintText: "budi@mail.com",
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                  ),
                  TextFormField(
                    style: MyTextTheme.inputStyle,
                    validator: (String? value) =>
                        value == '' ? "Nama harus diisi" : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: nameController,
                    decoration: const InputDecoration(
                        hintStyle: MyTextTheme.hintStyle,
                        labelStyle: MyTextTheme.labelStyle,
                        prefixIcon: Icon(
                          Icons.person,
                          size: 16,
                        ),
                        labelText: "Nama",
                        hintText: "Budi Lesmana",
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                  ),
                  TextFormField(
                    style: MyTextTheme.inputStyle,
                    validator: (String? value) =>
                        value == '' ? "Pesan harus diisi" : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: messageController,
                    decoration: const InputDecoration(
                        hintStyle: MyTextTheme.hintStyle,
                        labelStyle: MyTextTheme.labelStyle,
                        prefixIcon: Icon(
                          Icons.note,
                          size: 16,
                        ),
                        labelText: "Pesan",
                        hintText:
                            "Artikel ini membahas perkembangan covid terbaru dan akan sangat bermanfaat jika dijadikan bahan edukasi",
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (validate()) {
                          EmailApi.sendEmail(
                              context: context,
                              name: nameController.text,
                              email: emailController.text,
                              subject: subjectController.text,
                              message: messageController.text);
                        }
                        // Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                      ),
                      child: const Text(
                        'Kirim',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
