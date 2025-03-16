# ���� System.Windows.Forms �� System.Windows.Media ����
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName PresentationCore

# ��ȡָ��Ŀ¼�µ����� WAV �ļ�
$wavDirectory = "D:\voiceroid\����\Ȱ��Ϣ����"
$wavFiles = Get-ChildItem -Path $wavDirectory -Filter *.wav | Select-Object -ExpandProperty FullName

# ����һ�� 0 �� WAV �ļ�����֮��������
$random = New-Object System.Random
$randomIndex = $random.Next(0, $wavFiles.Count)

# ��ȡ���ѡ��� WAV �ļ�·��
$randomWav = $wavFiles[$randomIndex]

# �������ѡ��� WAV �ļ�
$player = New-Object System.Windows.Media.MediaPlayer
$player.Open([Uri]::new("file:///$randomWav"))
$player.Play()

# ����������Ϣ
$form = New-Object System.Windows.Forms.Form
$form.Text = "��Ϣ����"
$form.Size = New-Object System.Drawing.Size(480, 380)
$form.StartPosition = "CenterScreen"

$label = New-Object System.Windows.Forms.Label
$label.Text = "�����һ�°ɣ�"
$label.AutoSize = $false
$label.Location = New-Object System.Drawing.Point(30, 30)
$form.Controls.Add($label)

# ������֪���ˡ���ť������ʼ״̬Ϊ���ɼ�
$button = New-Object System.Windows.Forms.Button
$button.Text = "֪����"
$button.Size = New-Object System.Drawing.Size(100, 50)
$button.Location = New-Object System.Drawing.Point(190, 300)
$button.Visible = $false
$button.Add_Click({
    $form.Close()
})
$form.Controls.Add($button)

# ����ʱ�߼�
$countdown = 5
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 1000
$timer.Add_Tick({
    $countdown--
    $button.Text = "֪���ˣ�$countdown��"
    if ($countdown -le 0) {
        $button.Text = "֪����"
        $timer.Stop()
        $button.Visible = $true
    }
})
$timer.Start()

$form.ShowDialog()