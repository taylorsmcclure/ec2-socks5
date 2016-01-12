# ec2-socks5

<p>Is your ISP throttling your traffic? Are you noticing decreased throughput to popular streaming sites at peak traffic times?</p>
<p>One way to get around this issue is using a SOCKS5 proxy. This PowerShell script will use one of your existing EC2 Linux instances as a SOCKS5 proxy to encrypt your traffic and subvert your ISP's connection throttling.</p>

<h3>Prerequisites</h3>
<ul>
<li>Launch an EC2 Linux instance. For my 100Mbps connection I find that a t2.nano with Amazon Linux works well.</li>
<li>Configure your SSH client to tunnel to your EC2 instance when connected. Instructions <a href="https://www.skyverge.com/blog/how-to-set-up-an-ssh-tunnel-with-putty/">PUTTY</a> <a href="http://www.bu.edu/tech/support/research/system-usage/getting-started/port-forwarding/">MobaXterm</a></li>
<li>Set your Windows Internet Options to use the correct local port to tunnel to your SOCKS5 Proxy. A guide for this can be found <a href="http://windows.microsoft.com/en-us/windows/change-internet-explorer-proxy-server-settings">here</a>.</li>
<li>Have the <a href="https://aws.amazon.com/powershell/">AWS PowerShell</a> package installed and profile setup on your local machine.</li>
</ul>


<h3>How to use ec2-socks5</h3>
<ol>
<li>Edit the ec2-socks5.ps1 variables to your liking.</li>
<li>Execute the script and choose to stop or start the EC2 Linux instance.</li>
<li>Use Putty or your SSH client of choice to connect to the instance and establish a tunnel.</li>
</ol>
