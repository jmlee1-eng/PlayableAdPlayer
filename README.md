# PlayableAdPlayer

플레이어블 광고를 모바일 디바이스 프레임에서 테스트하는 도구

**✨ JSON 파일 수정 불필요! 폴더에 파일만 넣으면 자동 인식**

---

## 🚀 초기 설정

### 1. GitHub Desktop 설치
https://desktop.github.com/

### 2. 이 폴더를 GitHub에 업로드
1. GitHub.com → New Repository → `PlayableAdPlayer`
2. GitHub Desktop → Add Local Repository → 이 폴더 선택
3. Publish repository

### 3. GitHub Pages 활성화
1. GitHub.com → 저장소 → Settings → Pages
2. Source: `main` 브랜치 → Save

### 4. 첫 접속 시 설정
페이지 접속하면 GitHub 사용자명/저장소명 입력 (1회만)

---

## 📁 폴더 구조

```
D:\00_GitRepos\PlayableAdPlayer\
├── index.html          ← 건드리지 마세요
└── ads/
    ├── FortressSaga/
    │   ├── 260121/         ← 날짜 폴더 (DDMMYY)
    │   │   ├── 001.html
    │   │   └── 002.html
    │   └── 250121/
    │       └── 001.html
    ├── HoleExpress/
    │   └── 260121/
    │       └── 001.html
    └── NinjaDefenders/
        └── ...
```

---

## ➕ 광고 추가하기

### 그냥 파일 복사하면 끝!

1. 날짜 폴더 만들기 (없으면)
   ```
   ads/FortressSaga/270121/
   ```

2. HTML 파일 복사
   ```
   ads/FortressSaga/270121/newad.html
   ```

3. GitHub Desktop에서 Commit & Push

**JSON 수정 없음! 자동으로 인식됨**

---

## ➕ 새 게임 추가하기

1. `ads/` 폴더 안에 게임 폴더 생성
   ```
   ads/NewGame/
   ```

2. 날짜 폴더 + HTML 파일 추가
   ```
   ads/NewGame/260121/001.html
   ```

3. GitHub Desktop에서 Commit & Push

---

## 📅 날짜 폴더 규칙

형식: `DDMMYY` (일월년)

예시:
- `260121` = 2025년 01월 26일
- `150225` = 2025년 02월 15일

**드롭다운에서 최신 날짜가 위에 표시됨**

---

## 🔗 링크 공유

```
?game=FortressSaga&ad=260121/001.html
?game=HoleExpress&ad=260121/001.html&device=galaxy-s23
```

---

## 📱 지원 디바이스

| 디바이스 | 해상도 |
|---------|--------|
| iPhone SE | 375 x 667 |
| iPhone 14 | 390 x 844 |
| iPhone 15 Pro Max | 430 x 932 |
| Galaxy S21 | 360 x 800 |
| Galaxy S23 | 360 x 780 |
| Galaxy Z Flip | 360 x 748 |

---

## ⚠️ 주의사항

- GitHub API 호출 제한: 시간당 60회 (인증 없이)
- 대량 파일 추가 시 한 번에 하는 게 좋음
- 폴더/파일명에 한글, 공백 피하기
