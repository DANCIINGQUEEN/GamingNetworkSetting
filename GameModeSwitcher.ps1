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

        # 네트워크 최적화 설정 적용
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f
        reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{network_id}" /v TCPACKFrequency /t REG_DWORD /d 1 /f
        reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{network_id}" /v TCPNoDelay /t REG_DWORD /d 1 /f
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSMQ" /v TCPNoDelay /t REG_DWORD /d 1 /f
    }
    else {
        Write-Host "💻 롤이 종료되었습니다. 일반 모드로 복구 중..."

        # Wi-Fi 자동 검색 다시 활성화
        netsh wlan set autoconfig enabled=yes interface=$interfaceName

        # 네트워크 설정 원래대로 복구
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 10 /f
        reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{network_id}" /v TCPACKFrequency /f
        reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{network_id}" /v TCPNoDelay /f
        reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSMQ" /v TCPNoDelay /f
    }

    Start-Sleep -Seconds 5  # 5초마다 체크
}
