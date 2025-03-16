# 加载 System.Windows.Forms 和 System.Windows.Media 程序集
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName PresentationCore

# 获取指定目录下的所有 WAV 文件
$wavDirectory = "D:\voiceroid\创作\劝休息语音"
$wavFiles = Get-ChildItem -Path $wavDirectory -Filter *.wav | Select-Object -ExpandProperty FullName

# 生成一个 0 到 WAV 文件数量之间的随机数
$random = New-Object System.Random
$randomIndex = $random.Next(0, $wavFiles.Count)

# 获取随机选择的 WAV 文件路径
$randomWav = $wavFiles[$randomIndex]

# 播放随机选择的 WAV 文件
$player = New-Object System.Windows.Media.MediaPlayer
$player.Open([Uri]::new("file:///$randomWav"))
$player.Play()

# 弹窗提醒休息
$form = New-Object System.Windows.Forms.Form
$form.Text = "休息提醒"
$form.Size = New-Object System.Drawing.Size(480, 380)
$form.StartPosition = "CenterScreen"

$label = New-Object System.Windows.Forms.Label
$label.Text = "起来活动一下吧！"
$label.AutoSize = $false
$label.Location = New-Object System.Drawing.Point(30, 30)
$form.Controls.Add($label)

# 创建“知道了”按钮，但初始状态为不可见
$button = New-Object System.Windows.Forms.Button
$button.Text = "知道了"
$button.Size = New-Object System.Drawing.Size(100, 50)
$button.Location = New-Object System.Drawing.Point(190, 300)
$button.Visible = $false
$button.Add_Click({
    $form.Close()
})
$form.Controls.Add($button)

# 倒计时逻辑
$countdown = 5
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 1000
$timer.Add_Tick({
    $countdown--
    $button.Text = "知道了（$countdown）"
    if ($countdown -le 0) {
        $button.Text = "知道了"
        $timer.Stop()
        $button.Visible = $true
    }
})
$timer.Start()

$form.ShowDialog()