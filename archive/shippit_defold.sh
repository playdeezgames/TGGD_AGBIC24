rm -rf ./pub-web
java -jar bob.jar -r ./TGGD_AGBIC24/ -platform js-web -bo pub-web resolve distclean build bundle
butler push pub-web/TGGD_AGBIC24 thegrumpygamedev/how-am-i-still-waiting-for-the-bus:web