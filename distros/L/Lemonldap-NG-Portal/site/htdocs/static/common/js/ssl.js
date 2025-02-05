// Generated by CoffeeScript 1.12.8
(function() {
  var sendUrl, tryssl;

  tryssl = function() {
    var path;
    path = window.location.pathname;
    console.log('path -> ', path);
    console.log('Call URL -> ', window.datas.sslHost);
    $.ajax(window.datas.sslHost, {
      dataType: 'json',
      xhrFields: {
        withCredentials: true
      },
      success: function(data) {
        sendUrl(path);
        return console.log('Success -> ', data);
      },
      error: function(result) {
        if (result.status === 0) {
          sendUrl(path);
        }
        if (result.responseJSON && 'error' in result.responseJSON && result.responseJSON.error === "9") {
          sendUrl(path);
        }
        if (result.responseJSON && 'html' in result.responseJSON) {
          $('#errormsg').html(result.responseJSON.html);
          $(window).trigger('load');
        }
        return console.log('Error during AJAX SSL authentication', result);
      }
    });
    return false;
  };

  sendUrl = function(path) {
    var form_url;
    form_url = $('#lform').attr('action');
    if (form_url.match(/^#$/)) {
      form_url = path;
    } else {
      form_url = form_url + path;
    }
    console.log('form action URL -> ', form_url);
    $('#lform').attr('action', form_url);
    return $('#lform').submit();
  };

  $(document).ready(function() {
    return $('.sslclick').on('click', tryssl);
  });

}).call(this);
