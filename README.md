# SeSACFarm
## 어플소개
새싹 수강생들이 함께 이용할수 있는 커뮤니티 앱 입니다.
### 개발기간
22.01.03 ~ 22.01.12

## 기술스택
`MVVM` `SnapKit` `RESTAPI` `URLSession` `Codable`
### 상세설명
- MVVM 패턴을 처음으로 적용했습니다.
- codeBaseUI 로 Snapkit 을 사용하여 만들었습니다.
- tableView의 extension과 ReuseableView Protocol을 만들어서 identifier처리를 자동적으로 할수 있게 구현했습니다.
- URLSession 으로 RestAPI 를 구현하고, CRUD를 모두 구현했습니다.
- URLSession 의 request 를 Generic타입을 이용하여 Decodable이 용이하도록 구현했습니다.
- 회원가입 및 로그인을 구현 했습니다.
- 로그인시 토큰이 생성되며 토큰이 만료될시 글 작성/수정, 댓글 작성/수정이 불가능하며, 메인화면으로 이동합니다.
- 글과 댓글 모두 작성/수정/삭제가 가능합니다.
- 실시간 정보를 확인하기 위해서 당겨서 새로고침 기능이 있습니다.
- 모든화면에 키보드 대응이 되어 있습니다.

## 트러블슈팅
- 댓글 달기 키보드 화면에서 키보드가 늦게 따라 올라오는 문제가 있었습니다. Notification Oserver 를 keyboardDidChangeFrameNotification -> keyboardWillChangeFrameNotification 변경하여 해결 했습니다.
- 댓글 달기 화면에서 키보드의 높이만큼 화면을 올려주는 과정에서 많은 생각이 있었습니다. 테이블뷰의 bottomView 의 높이를 동적으로 변경해주는 방법으로 해결했습니다.
- tableViewCell 의 높이를 동적 높이를 적용 했는데 제대로 구현이 안되었습니다. cell 내부의 ui 를 잡을때 top, bottom 모두 잡아주는것으로 해결했습니다.

## 구현사진
|로그인화면|글쓰기 화면|댓글쓰기 화면|
|----|----|----|
|<img src="https://user-images.githubusercontent.com/89408824/156142401-3df19201-5bae-45e3-bb4e-6117bab390ee.png" width="210" height="350"/>|<img src="https://user-images.githubusercontent.com/89408824/156141920-dd31cf53-b848-4916-90eb-bc6e86fa7d3c.png" width="210" height="350"/>|<img src="https://user-images.githubusercontent.com/89408824/156141912-3386cc9f-eb53-48b9-b963-ed9b7010e993.png" width="210" height="350"/>

|글 수정|글 삭제|
|-----|----|
|<img src="https://user-images.githubusercontent.com/89408824/156129620-6ec49ee9-3cd4-431b-b22c-e649b18593eb.gif" width="210" height="350"/>| <img src="https://user-images.githubusercontent.com/89408824/156141604-43350097-d268-4937-8652-4bfc62a3c8bd.gif" width="210" height="350"/>|
- 댓글 수정/삭제 도 같은 프로세스로 진행됩니다.
