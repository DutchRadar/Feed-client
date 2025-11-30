# DutchRadar.nl Feed Client

- These scripts aid in setting up your current ADS-B receiver to feed [dutchradar.nl](https://dutchradar.nl)
- They will not disrupt any existing feed clients already present

## 1: Find coordinates / elevation:

<https://www.freemaptools.com/elevation-finder.htm>

## 2: Install the dutchradar feed client

```
curl -L -o /tmp/dutchradarfeed.sh https://raw.githubusercontent.com/dutchradar/Feed-client/master/install.sh
sudo bash /tmp/dutchradarfeed.sh
```

## 3: Check if your feed is working

That one's easy! Just go to <https://dutchradar.nl/sync/0A/> and you should show as receiver.
This only work if Mlat connection is active. 

Want to make sure? You can get into looking at your connections..

The feed IP for dutchradar.nl is currently 5.255.77.82

```
$ host feed.dutchradar.nl
feed.dutchradar.nl has address 5.255.77.82
```

Expected Output:
```
$ netstat -t -n | grep -E '30004|31090'
tcp        0    182 localhost:43530     5.255.77.82:31090      ESTABLISHED
tcp        0    410 localhost:47332     5.255.77.82:30004      ESTABLISHED
```

### Update the feed client without reconfiguring

```
curl -L -o /tmp/dutchradarupdate.sh https://raw.githubusercontent.com/DutchRadar/Feed-client/master/update.sh
sudo bash /tmp/dutchradarupdate.sh
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
curl -L -o /tmp/Dutchradarfeed.sh https://raw.githubusercontent.com/dutchradar/Feed-client/master/install.sh
sudo bash /tmp/Dutchradarfeed.sh
```

### Disable / Enable dutchradar.nl MLAT-results in your main decoder interface (readsb / dump1090-fa)

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
