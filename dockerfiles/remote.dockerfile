FROM kim/tutorial

RUN apt-get update && \
    # SSHサーバをインストール
    apt-get install -q -y ssh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    # SSHサーバが動作するために必要なsockファイルが配置されるディレクトリを用意
    mkdir /var/run/sshd && \
    # rootでログインできるようにパスワードを設定
    echo 'root:password' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config # 

# 公開鍵コピー
WORKDIR /root/.ssh
COPY id_rsa.pub authorized_keys
# SSHポートを公開する
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]