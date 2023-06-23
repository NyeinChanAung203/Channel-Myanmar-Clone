String selectLinkImage(String name) {
  if (name.toLowerCase().contains('megaup')) {
    return "assets/images/megaup.png";
  } else if (name.toLowerCase().contains('mega.nz')) {
    return "assets/images/megaz.png";
  } else if (name.toLowerCase().contains('yoteshin')) {
    return "assets/images/yoteshin.png";
  } else if (name.toLowerCase().contains('streamsb')) {
    return "assets/images/streamsb.png";
  } else if (name.toLowerCase().contains('streamvid')) {
    return "assets/images/streamvid.png";
  } else if (name.toLowerCase().contains('usersdrive')) {
    return "assets/images/userdrive.jpg";
  } else {
    return "assets/images/internet.png";
  }
}
