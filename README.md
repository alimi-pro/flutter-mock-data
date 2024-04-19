# alimipro_mock_data

알리미 프로 백업 Mock 데이터

## Mock 데이터로 작업 가이드

### Firebase 설정
```shell
flutterfire configure
```

### Firebase 에뮬레이터 시동
```shell
# 데이터 복원 & 백업
firebase emulators:start --import=./saved-data --export-on-exit=./saved-data
```

### 테스트 제약 사항
- Android 에뮬레이터 또는 iOS 시뮬레이터로 실행
- Android 에서는 로컬 서버에 10.0.2.2 로 접속
- iOS 에서는 로컬 서버에 localhost 로 접속

## 테스트 계정
test@gmail.com
123456