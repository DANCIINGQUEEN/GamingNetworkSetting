# 🚀 자동 네트워크 최적화 프로그램 (롤 실행 감지)

이 프로그램은 **League of Legends(롤) 실행 여부를 감지하여 네트워크 설정을 자동으로 변경하는 PowerShell 스크립트**입니다.  
**롤이 실행되면 Wi-Fi 자동 검색을 비활성화하여 네트워크 최적화를 적용하고, 게임이 종료되면 원래 설정으로 복구**합니다.

---

## 📌 주요 기능
✅ **롤(League of Legends) 실행 시 Wi-Fi 자동 검색 비활성화**  
✅ **롤 종료 시 Wi-Fi 자동 검색 다시 활성화**  
✅ **PowerShell 스크립트(`.ps1`)를 사용하여 자동 실행**  
✅ **Windows 시작 시 자동으로 실행되도록 설정**  

---

## 📂 파일 구성
```
/GameModeSwitcher/
│── AutoGameMode.ps1   # 롤 실행 여부를 감지하여 네트워크 설정 변경하는 PowerShell 스크립트
│── README.md          # 사용 방법 및 설정 가이드
```

---

## 📝 스크립트 내용 (`AutoGameMode.ps1`)
```powershell
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$gameProcess = "League of Legends"  # 롤 게임 실행 프로세스 이름
$interfaceName = "Wi-Fi"  # 사용 중인 네트워크 인터페이스 이름

while ($true) {
    # 롤 실행 여부 확인
    $isRunning = Get-Process -Name $gameProcess -ErrorAction SilentlyContinue

    if ($isRunning) {
        Write-Host "🎮 롤이 실행 중입니다. 게임 모드 적용 중..."
        netsh wlan set autoconfig enabled=no interface=$interfaceName  # Wi-Fi 자동 검색 비활성화
    }
    else {
        Write-Host "💻 롤이 종료되었습니다. 일반 모드로 복구 중..."
        netsh wlan set autoconfig enabled=yes interface=$interfaceName  # Wi-Fi 자동 검색 다시 활성화
    }

    Start-Sleep -Seconds 60  # 60초마다 롤 실행 여부 확인
}
```

---

## 🛠️ 사용 방법

### 1️⃣ 스크립트 실행 정책 변경 (한 번만 설정)
PowerShell 스크립트 실행을 허용하려면, 먼저 아래 명령어를 입력해야 합니다.
```powershell
Set-ExecutionPolicy Unrestricted -Scope CurrentUser
```

---

### 2️⃣ 스크립트 수동 실행 방법
PowerShell을 관리자 권한으로 실행한 후, 아래 명령어 입력:
```powershell
powershell -ExecutionPolicy Bypass -File "C:\GameModeSwitcher\AutoGameMode.ps1"
```

---

### 3️⃣ Windows 시작 시 자동 실행 설정 (작업 스케줄러 등록)
**컴퓨터를 켜면 자동으로 실행되도록 설정하려면 Windows 작업 스케줄러(Task Scheduler)에 등록해야 합니다.**  

#### ✅ 작업 스케줄러에 등록하는 방법
1. `Win + R` → `taskschd.msc` 입력 후 `Enter`
2. **"작업 스케줄러 라이브러리"**에서 **"기본 작업 만들기" 클릭**
3. **작업 이름**: `"AutoGameMode"`
4. **트리거 설정**: `"로그온할 때"`
5. **작업 실행 프로그램**: `"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"`
6. **추가 인수**:
   ```powershell
   -ExecutionPolicy Bypass -WindowStyle Hidden -File "C:\GameModeSwitcher\AutoGameMode.ps1"
   ```
7. **"가장 높은 권한으로 실행" 체크 후 저장**
8. Windows를 재부팅하여 자동 실행되는지 확인

---

## 🔄 작동 원리
1. PowerShell 스크립트가 **백그라운드에서 실행**됩니다.
2. **롤 실행 여부(`League of Legends.exe` 감지)**를 60초마다 확인합니다.
3. 롤이 실행되면 **Wi-Fi 자동 검색을 비활성화**하여 네트워크 최적화를 수행합니다.
4. 롤이 종료되면 **Wi-Fi 자동 검색을 다시 활성화**합니다.
5. 스크립트는 **지속적으로 실행되며**, 사용자가 추가 작업을 할 필요가 없습니다.

---

## ❌ 문제 해결
### 1️⃣ PowerShell 스크립트 실행이 안될 때
- **해결 방법:** 실행 정책을 변경해야 할 수도 있음.
```powershell
Set-ExecutionPolicy Unrestricted -Scope CurrentUser
```

### 2️⃣ 작업 스케줄러에서 등록한 작업이 안 보일 때
- 작업 스케줄러에서 **"숨김된 작업 표시"** 옵션을 활성화하여 확인.

### 3️⃣ 자동 실행이 안될 때
- 작업 스케줄러에서 `AutoGameMode` 작업을 **수동으로 실행**하여 정상 작동하는지 확인.

---

## 🚀 최종 정리
✅ **롤 실행 여부를 감지하여 네트워크 설정을 자동 변경**  
✅ **Wi-Fi 자동 검색을 비활성화하여 네트워크 성능 최적화**  
✅ **작업 스케줄러(Task Scheduler)에 등록하여 Windows 시작 시 자동 실행**  
✅ **백그라운드에서 실행되므로 사용자가 추가 조작할 필요 없음**  

🎮 **이제 롤을 실행하면 자동으로 네트워크 최적화가 적용됩니다!** 🚀🔥  
**버그 또는 개선할 점이 있으면 언제든지 수정할 수 있습니다.** 😆  
