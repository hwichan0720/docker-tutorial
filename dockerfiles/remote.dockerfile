FROM kim/tutorial

RUN apt-get update && \
    # SSHサーバをインストール
    apt-get install -q -y ssh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    # SSHサーバが動作するために必要なsockファイルが配置されるディレクトリを用意
    mkdir /var/run/sshd && \
    # rootでログインできるようにするため、パスワードを設定
    # echo 'root:password' | chpasswd && \
    # パスワードでのログインをできないようにする
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config # 

# SSHで使用する公開鍵をここでコピーする
WORKDIR /root/.ssh
COPY id_rsa.pub authorized_keys
# SSHポートを公開する(Docker Composeで別のポートにバインドするので22番ポートのまま)
EXPOSE 22

# その他開発に必要なプログラムのインストールなど

CMD ["/usr/sbin/sshd", "-D"]