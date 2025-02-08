[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$gameProcess = "League of Legends"  # 게임 실행 프로세스
$interfaceName = "Wi-Fi"  # 사용 중인 네트워크 인터페이스 이름

while ($true) {
    # 롤 게임 실행 여부 확인
    $isRunning = Get-Process -Name $gameProcess -ErrorAction SilentlyContinue

    if ($isRunning) {
        Write-Host "🎮 롤이 실행 중입니다. 게임 모드 적용 중..."
        
        # Wi-Fi 자동 검색 비활성화
        netsh wlan set autoconfig enabled=no interface=$interfaceName

    }
    else {
        Write-Host "💻 롤이 종료되었습니다. 일반 모드로 복구 중..."

        # Wi-Fi 자동 검색 다시 활성화
        netsh wlan set autoconfig enabled=yes interface=$interfaceName

    }

    Start-Sleep -Seconds 60  # 5초마다 체크
}
