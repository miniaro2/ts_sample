# TypeScript + JSP 샘플 프로젝트
  황상범(miniaron@empal.com)

## 📋 프로젝트 개요

이 프로젝트는 **TypeScript를 JSP 환경에서 사용하는 방법**을 보여주는 샘플 애플리케이션입니다. 
현대적인 클라이언트 사이드 개발(TypeScript)과 전통적인 서버 사이드 렌더링(JSP)을 효과적으로 결합한 예제입니다.

## 🎯 주요 목적

- TypeScript의 타입 안전성과 개발 편의성 활용
- JSP를 API 엔드포인트로 활용하여 데이터 제공
- 클라이언트-서버 간 비동기 통신 구현
- ES5 호환성을 위한 TypeScript 컴파일 과정 이해

## 🏗️ 프로젝트 구조

```
ts_sample/
├── ts/                          # TypeScript 소스 코드
│   └── main.ts                 # 메인 TypeScript 파일
├── src/
│   └── main/
│       └── webapp/             # 웹 애플리케이션 리소스
│           ├── index.jsp        # 메인 JSP 페이지
│           ├── users_data.jsp   # JSON API JSP
│           └── js/              # 컴파일된 JavaScript 파일
│               └── main.js      # TypeScript에서 컴파일된 JS
├── target/                      # Maven 빌드 결과물
├── node_modules/                # npm 의존성
├── package.json                 # npm 설정 및 스크립트
├── pom.xml                      # Maven 프로젝트 설정
└── tsconfig.json               # TypeScript 컴파일러 설정
```

## 🚀 사용 방법

### 1. 의존성 설치
```bash
npm install
```

### 2. TypeScript 컴파일
```bash
npm run build
```
- `ts/main.ts` → `src/main/webapp/js/main.js`로 컴파일
- ES5 호환 JavaScript 생성

### 3. 웹 애플리케이션 빌드
```bash
mvn clean package
```
- WAR 파일 생성: `target/jsp-typescript-sample.war`

### 4. 웹서버 실행
```bash
mvn jetty:run
```
- Jetty 서버가 8080 포트에서 실행
- 접속 URL: `http://localhost:8080/jsp-typescript-sample/`

## ⚙️ 설정 파일 설명

### package.json
```json
{
  "name": "jsp-typescript-sample",
  "scripts": {
    "build": "tsc"  // TypeScript 컴파일 명령어
  },
  "devDependencies": {
    "typescript": "^4.8.4"
  }
}
```

### tsconfig.json
```json
{
  "compilerOptions": {
    "target": "es5",                    // ES5 호환성
    "lib": ["es5", "es2015.promise", "dom"],  // Promise 지원
    "module": "commonjs",               // 모듈 시스템
    "outDir": "src/main/webapp/js",    // 출력 디렉토리
    "rootDir": "ts",                   // 소스 디렉토리
    "strict": true,                     // 엄격한 타입 체크
    "esModuleInterop": true
  }
}
```

### pom.xml
```xml
<project>
    <artifactId>jsp-typescript-sample</artifactId>
    <packaging>war</packaging>
    
    <dependencies>
        <!-- Servlet API -->
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>javax.servlet-api</artifactId>
        </dependency>
        <!-- JSON 처리 -->
        <dependency>
            <groupId>com.google.code.gson</groupId>
            <artifactId>gson</artifactId>
        </dependency>
    </dependencies>
    
    <build>
        <plugins>
            <!-- Jetty 플러그인 -->
            <plugin>
                <groupId>org.eclipse.jetty</groupId>
                <artifactId>jetty-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

## 🔄 개발 워크플로우

### 1. 개발 단계
- `ts/main.ts` 파일에서 TypeScript 코드 작성
- 타입 정의, 인터페이스, 비동기 함수 등 활용

### 2. 컴파일 단계
- `npm run build` 실행
- TypeScript 컴파일러가 `.ts`를 `.js`로 변환
- ES5 호환성을 위한 폴리필 코드 자동 생성

### 3. 빌드 단계
- `mvn clean package` 실행
- WAR 파일 생성 및 의존성 포함

### 4. 실행 단계
- `mvn jetty:run` 실행
- 웹 브라우저에서 애플리케이션 접근

## 💡 핵심 기능

### 클라이언트 사이드 (TypeScript)
```typescript
interface User {
  name: string;
  email: string;
}

async function fetchAndDisplayUsers(): Promise<void> {
  const response = await fetch('users_data.jsp');
  const users: User[] = await response.json();
  // DOM 조작 및 데이터 표시
}
```

### 서버 사이드 (JSP)
```jsp
<%@ page contentType="application/json; charset=UTF-8" %>
<%@ page import="com.google.gson.Gson" %>
<%
    // 사용자 데이터 생성
    List<Map<String, String>> userList = new ArrayList<>();
    // ... 데이터 추가
    
    // JSON으로 변환하여 응답
    String json = new Gson().toJson(userList);
    out.print(json);
%>
```

## 🔍 동작 원리

1. **페이지 로드**: `index.jsp`에서 컴파일된 `main.js` 로드
2. **버튼 클릭**: "사용자 불러오기" 버튼 클릭 시 `fetchAndDisplayUsers()` 함수 실행
3. **API 호출**: `fetch('users_data.jsp')`로 서버에 요청
4. **데이터 응답**: JSP가 JSON 형태로 사용자 데이터 반환
5. **DOM 업데이트**: 받은 데이터를 테이블에 동적으로 표시

## 📊 코드 크기 비교

| 파일 | 줄 수 | 크기 | 설명 |
|------|--------|------|------|
| `main.ts` | 39줄 | ~1.2KB | 원본 TypeScript |
| `main.js` | 78줄 | ~3.5KB | 컴파일된 JavaScript |

**증가율**: 약 **2배** (ES5 호환성을 위한 폴리필 때문)

## 🎨 장점

- **타입 안전성**: 컴파일 시점에 오류 검출
- **개발 편의성**: IntelliSense, 자동완성 등
- **브라우저 호환성**: ES5로 컴파일하여 구형 브라우저 지원
- **유지보수성**: 타입 정보로 코드 가독성 향상
- **점진적 도입**: 기존 JSP 프로젝트에 TypeScript 단계적 적용 가능

## 🚨 주의사항

- TypeScript 컴파일 후 JavaScript 파일이 자동으로 생성됨
- `tsconfig.json`의 `rootDir`과 `outDir` 설정 확인 필요
- ES5 타겟 사용 시 Promise 폴리필 자동 포함
- JSP 파일의 Content-Type을 `application/json`으로 설정

## 🔧 문제 해결

### TypeScript 컴파일 오류
- `rootDir` 설정이 실제 TypeScript 파일 위치와 일치하는지 확인
- `lib` 설정에 필요한 라이브러리 포함 여부 확인

### 웹서버 실행 오류
- 포트 8080이 사용 중인지 확인
- Maven 의존성 다운로드 완료 여부 확인

## 📚 추가 학습 자료

- [TypeScript 공식 문서](https://www.typescriptlang.org/)
- [JSP 튜토리얼](https://docs.oracle.com/javaee/5/tutorial/doc/bnagx.html)
- [Maven 가이드](https://maven.apache.org/guides/)
- [Jetty 문서](https://www.eclipse.org/jetty/documentation/)

---

**프로젝트 생성일**: 2025년 9월 3일  
**버전**: 1.0.0  
**라이선스**: MIT
