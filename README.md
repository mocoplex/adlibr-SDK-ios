# ADLib iOS SDK 적용 샘플 프로젝트

<br>
애드립 광고 연동 및 애드립에서 제공하는 광고 플랫폼 미디에이션 연동을 적용하기위한 샘플 프로젝트를 포함합니다. <br>
<br>
샘플 워크스페이스는 아래와 같이 두 가지 프로젝트를 포함하고있으며, <br>
구 버전은 기존 AdlibManager를 이용하여 연동하는 방법을 제공하는 샘플 프로젝트이며, <br>
신규 버전은 새로 작성된 신규 클래스를 사용하여 연동하는 방법을 제공하는 샘플 프로젝트입니다. 
<br>

1.신규 샘플 프로젝트 (adlibrTestUniversal/adlibrSample_New/) <br>
2.구버전 샘플 프로젝트 지원중단 <br>
<br>

## 프로젝트 설정 및 가이드 
* [프로젝트 설정 가이드 링크](http://mkt.adlibr.com/ssp/menual/ssp_sdk_ios.html)
* [신규버전 배너 연동 가이드 링크]( https://github.com/mocoplex/adlibr-SDK-ios/blob/master/adlibrTestUniversal/adlibrSample_New/README.md)
<br>

## ATS 설정
> !!! ATS 관련 HTTPS 지원 SDK 업데이트 예정입니다. <br>
> iOS 9 ATS(App Transport Security) 관련 가이드 업데이트 <br>
> XCode 7 스토어 업로드시 에러 사항 수정 (Adlib.bundle 파일 교체 필요)<br>
> XCode 7 이상 사용시 최신 SDK 및 Adlib.bundle 파일 교체 필요<br>
> 샘플 프로젝트 bitcode 설정은 기본 NO로 설정<br>

## Bitcode 지원
비트코드를 지원하기 위해서는 현재 샘플프로젝트에서 사용하고 있는 Adlib.framework 외의 별도의 비트코드
지원 버전 SDK를 추가하시고 사용하셔야합니다.<br>
해당 리소스들은 샘플 프로젝트 내부의 아래 경로에 포함되어있습니다.<br>
https://github.com/mocoplex/adlibr-SDK-ios/tree/master/adlibrTestUniversal/adlibrSample_New/ADLibSample/ADLibFramework_bitcode
<br>

## 미디에이션 플랫폼 SDK 지원 
> Adfit 3.0.1 <br>
> Admob 7.27.0 <br>
> Facebook 4.27.0 <br>
> Cauly 3.1 <br>
<br>

## SDK Version History

SDK version 4.3.4.2 (2017.05.30)
> 네이티브 동영상 광고 기본 UI 변경<br>

SDK version 4.3.0.7 (2017.03.31)
> SDK 미디에이션 기능 업데이트<br>

SDK version 4.3.0.0 (2017.02.21)
> SDK 네이티브 동영상광고 상품추가<br>

SDK version 4.2.3.0 (2017.01.18)
> SDK 배너뷰 BackFill 지원기능 추가<br>

SDK version 4.2.2.0 (2016.12.05)
> SDK 내부개선 <br>

SDK version 4.2.1.0 (2016.09.01)
> 전면광고 상품에 동영상 앱광고 상품 추가 <br>

SDK version 4.2.0.1 (2016.08.22)
> 애드립 및 미디에이션 광고 적용 신규 클래스 지원 <br>

SDK version 4.1.5.4 (2016.03.24)
> 3D 엔진업데이트 <br>
> 엔진업데이트에 따른 리소스파일 교체 (*.lua파일 최신으로 교체 필수) <br>

SDK version 4.1.5.2 (2016.01.22)
> 3D ICon 광고 상품 추가 및 관련 샘플 추가 <br>

SDK version 4.1.4.0 (2015.10.19)
> iOS 9 빌드 적용 <br>
> BitCode Compile 미적용 버전 (필요시 개별요청)<br>
> ADLibSession 일부 클래스 메소드 제거<br>
> ALNativeAdTableHelper 관련 메소드 수정<br>

SDK version 4.1.3.1 (2015.7.31)
> 네이티브 지면 광고 지원 및 샘플 프로젝트 추가

SDK version 4.1.2.0 (2015.7.6)
> 광고 관련 UIWebView 처리 수정

SDK version 4.1.1.0 (2015.6.25)
> 광고 컨테이너 뷰 내부에서 배너뷰의 위치 상/하단 정렬 옵션 추가

SDK version 4.1.0.0 (2015.6.12)
> 3D 광고 추가<br>3D 광고 지원에 필요한 프로젝트 설정이 추가 되었습니다. 자세한 내용은 링크를 확인하세요.
<http://mkt.adlibr.com/ssp/menual/ssp_sdk_ios.html>

SDK version 4.0.2 (2015.5.19)
> 미디에이션 기능 개선

SDK version 4.0.1 (2015.5.13)
> 디버깅 모드 로그 추가

SDK version 4.0.0 (2015.3.19)
> 비디오 광고 추가
