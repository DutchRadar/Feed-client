# adsb.lol feed client classic

- These scripts aid in setting up your current ADS-B receiver to feed [adsb.lol](https://adsb.lol)
- They will not disrupt any existing feed clients already present

## 1: Find coordinates / elevation:

<https://www.freemaptools.com/elevation-finder.htm>

## 2: Install the dutchradar feed client

```
curl -L -o /tmp/LOLfeed.sh https://raw.githubusercontent.com/dutchradar/feed/master/install.sh
sudo bash /tmp/LOLfeed.sh
```

## 3: Check if your feed is working

That one's easy! Just go to <https://adsb.lol> and you should show as feeding.

Want to make sure? You can get into looking at your connections..

The feed IP for adsb.lol is currently 142.132.241.63

```
$ host feed.adsb.lol
feed.adsb.lol has address 142.132.241.63
```

Expected Output:
```
$ netstat -t -n | grep -E '30004|31090'
tcp        0    182 localhost:43530     142.132.241.63:31090      ESTABLISHED
tcp        0    410 localhost:47332     142.132.241.63:30004      ESTABLISHED
```

### Optional: local interface for your data http://192.168.X.XX/dutchradar

Install / Update:
```
sudo bash /usr/local/share/dutchradar/git/install-or-update-interface.sh
```
Remove:
```
sudo bash /usr/local/share/tar1090/uninstall.sh dutchradar
```

### Update the feed client without reconfiguring

```
curl -L -o /tmp/LOLupdate.sh https://raw.githubusercontent.com/DutchRadar/Feed-client/master/update.sh
sudo bash /tmp/LOLupdate.sh
```


### If you encounter issues, please do a reboot and then supply these logs on the forum (last 20 lines for each is sufficient):

```
sudo journalctl -u dutchradar-feed --no-pager
sudo journalctl -u dutchradar-mlat --no-pager
```


### Display the configuration

```
cat /etc/default/dutchradar
```

### Changing the configuration

This is the same as the initial installation.
If the client is up to date it should not take as long as the original installation,
otherwise this will also update the client which will take a moment.

```
curl -L -o /tmp/Dutchradarfeed.sh https://raw.githubusercontent.com/dutchradar/feed/master/install.sh
sudo bash /tmp/Dutchradarfeed.sh
```

### Disable / Enable adsb.lol MLAT-results in your main decoder interface (readsb / dump1090-fa)

- Disable:

```
sudo sed --follow-symlinks -i -e 's/RESULTS=.*/RESULTS=""/' /etc/default/dutchradar
sudo systemctl restart dutchradar-mlat
```
- Enable:

```
sudo sed --follow-symlinks -i -e 's/RESULTS=.*/RESULTS="--results beast,connect,127.0.0.1:30104"/' /etc/default/dutchradar
sudo systemctl restart dutchradar-mlat
```

### Restart

```
sudo systemctl restart dutchradar-feed
sudo systemctl restart dutchradar-mlat
```


### Systemd Status

```
sudo systemctl status dutchradar-mlat
sudo systemctl status dutchradar-feed
```


### Removal / disabling the services:

```
sudo bash /usr/local/share/dutchradar/uninstall.sh
```

If the above doesn't work, you may be using an old version that didn't have the uninstall script, just disable the services and the scripts won't run anymore:

```
sudo systemctl disable --now dutchradar-feed
sudo systemctl disable --now dutchradar-mlat
```
