// 이 파일은 앱의 '개발자 노트' 화면을 만드는 코드를 담고 있어요.
// 최신 업데이트 내역이나 공지사항을 보여주는 게시판 형태의 화면이에요.

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // 링크를 열기 위해 필요해요.
import 'package:flutter/services.dart'; // 클립보드 사용을 위해 추가
import 'package:numerology/generated/l10n/app_localizations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

// 링크 버튼 정보를 담는 클래스예요.
class NoteAction {
  final String label; // 버튼에 들어갈 글자
  final String url; // 연결할 링크 주소
  NoteAction({required this.label, required this.url});
}

// 개발자 노트(게시글)의 데이터 구조를 정의해요.
class DeveloperNote {
  final String date; // 작성 날짜 (YYYY-MM-DD)
  final String titleKo; // 글 제목 (한국어)
  final String titleEn; // 글 제목 (영어)
  final String contentKo; // 글 내용 (한국어)
  final String contentEn; // 글 내용 (영어)
  final List<NoteAction> actions; // (선택) 여러 개의 링크 버튼들

  DeveloperNote({
    required this.date,
    required this.titleKo,
    required this.titleEn,
    required this.contentKo,
    required this.contentEn,
    this.actions = const [], // 기본값은 빈 리스트
  });
}

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    // 현재 언어 코드를 확인해요 (ko 또는 en)
    final isKorean = Localizations.localeOf(context).languageCode == 'ko';

    // 여기에 게시글 데이터를 추가해요. (최신 글이 위로 오도록 리스트의 앞쪽에 넣어주세요)
    final List<DeveloperNote> notes = [

      // ▼▼▼ [최신 글] ▼▼▼

 DeveloperNote(
        date: '2026-03-11',
        titleKo: '<26-03-11 업데이트>',
        titleEn: '<26-03-11 Update>',
        contentKo: '''
안녕하세요 아리온 아인입니다.
이번 1.2.0+33 업데이트 사항입니다.

1. 오픈카톡 커뮤니티 링크 추가
2. 수비학 영어 계산 공식 추가
3. 기타 내부 버그 수정 및 안정성 개선

앱을 편하게 사용하시고 계시거나 or 불편한 점이 있다면, 커뮤니티에 오셔서 수비학, 점성학에 관한 
이야기와, 앱에 대한 피드백을 나눠주세요. 

따뜻한 리뷰는 개발자에게 큰 힘이 됩니다.

감사합니다
아리온 아인 드림
''',
        contentEn: '''
Hello, this is Arion Ayin.
This is a 1.2.0+51 update.

1. Correct void notification error
2. Added Void Calendar feature
3. Add Kakao Talk Community Open Link

If you have any feedback or questions, please contact us.
''',
        actions: [
          NoteAction(
            label: appLocalizations.btnReview, // '리뷰 남기러 가기' / 'Leave a Review'
            url:
                'https://play.google.com/store/apps/details?id=com.numerology.finderapp',
          ),
          NoteAction(
            label:
                appLocalizations
                    .btnContact, // '개발자에게 한마디' / 'Contact Developer'
            url: 'mailto:arion.ayin@gmail.com',
          ),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.description,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              appLocalizations.infoScreenTitle,
            ), // '개발자 노트' / 'Developer Notes'
          ],
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: Theme.of(context).appBarTheme.elevation,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child:
                    notes.isEmpty
                        ? Center(
                          child: Text(
                            appLocalizations.noPostsFound, // '등록된 게시글이 없습니다.'
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color?.withAlpha((0.6 * 255).toInt()),
                            ),
                          ),
                        )
                        : ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                      final note = notes[index];
                      // 현재 언어에 맞는 제목과 내용을 선택해요
                      final title = isKorean ? note.titleKo : note.titleEn;
                      final content =
                          isKorean ? note.contentKo : note.contentEn;

                      return Card(
                        key: ValueKey(note.date),
                        margin: const EdgeInsets.only(bottom: 16.0),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: Theme.of(context).cardColor,
                        child: Theme(
                          data: Theme.of(
                            context,
                          ).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            tilePadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            childrenPadding: const EdgeInsets.fromLTRB(
                              16,
                              0,
                              16,
                              16,
                            ),
                            initiallyExpanded: false,
                            collapsedBackgroundColor: Theme.of(context).cardColor,
                            backgroundColor: Theme.of(context).cardColor.withAlpha((0.8 * 255).toInt()),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  note.date,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  title, // 언어에 맞는 제목 표시
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(top: 8.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Theme.of(
                                        context,
                                      ).dividerColor.withAlpha((0.1 * 255).toInt()),
                                    ),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      content, // 언어에 맞는 내용 표시
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1.5,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.color
                                            ?.withAlpha((0.8 * 255).toInt()),
                                      ),
                                    ),
                                    // ▼▼▼ [링크 버튼 목록 표시] ▼▼▼
                                    if (note.actions.isNotEmpty) ...[
                                      const SizedBox(height: 20),
                                      ...note.actions
                                          .map<Widget>(
                                            (action) => Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 8.0,
                                              ),
                                              child: OutlinedButton.icon(
                                                onPressed: () async {
                                                  try {
                                                    await FirebaseAnalytics.instance.logEvent(
                                                      name: 'click_note_action',
                                                      parameters: {
                                                        'label': action.label,
                                                        'url': action.url,
                                                      },
                                                    );
                                                    final uri = Uri.parse(
                                                      action.url,
                                                    );
                                                    bool launched = false;
                                                    if (await canLaunchUrl(
                                                      uri,
                                                    )) {
                                                      launched = await launchUrl(
                                                        uri,
                                                        mode:
                                                            LaunchMode
                                                                .externalApplication,
                                                      );
                                                    } else {
                                                      launched =
                                                          await launchUrl(uri);
                                                    }

                                                    if (!launched) {
                                                      throw 'Could not launch';
                                                    }
                                                  } catch (e) {
                                                    if (context.mounted) {
                                                      if (action.url.startsWith(
                                                        'mailto:',
                                                      )) {
                                                        final email = action.url
                                                            .replaceFirst(
                                                              'mailto:',
                                                              '',
                                                            );
                                                        await Clipboard.setData(
                                                          ClipboardData(
                                                            text: email,
                                                          ),
                                                        );
                                                        if (!context.mounted) return;
                                                        ScaffoldMessenger.of(
                                                          context,
                                                        ).showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              appLocalizations
                                                                  .msgEmailCopied,
                                                            ),
                                                            duration:
                                                                const Duration(
                                                                  seconds: 2,
                                                                ),
                                                            behavior: SnackBarBehavior.floating,
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                          ),
                                                        );
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                          context,
                                                        ).showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              appLocalizations
                                                                  .msgAppNotFound,
                                                            ),
                                                            duration:
                                                                const Duration(
                                                                  seconds: 2,
                                                                ),
                                                            behavior: SnackBarBehavior.floating,
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                          ),
                                                        );
                                                      }
                                                    }
                                                  }
                                                },
                                                icon: const Icon(Icons.link),
                                                label: Text(action.label),
                                                style: OutlinedButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                      ),
                                                  alignment:
                                                      Alignment
                                                          .center, // 버튼 글자 가운데 정렬
                                                  foregroundColor: Colors.black,
                                                  side: const BorderSide(color: Colors.black, width: 1),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ],
                                    // ▲▲▲ 여기까지 ▲▲▲
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Text(
                  appLocalizations.copyrightText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).textTheme.bodySmall?.color?.withAlpha((0.5 * 255).toInt()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
