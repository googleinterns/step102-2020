const API_KEY = 'AIzaSyAed5yuxCNrXlEFAqSoWwAQpE3Ng95Tzl8';
const DISCOVERY_DOCS = [
  "https://docs.googleapis.com/$discovery/rest?version=v1",
  "https://www.googleapis.com/discovery/v1/apis/drive/v3/rest"
];

const NOTES_TEMPLATE_DOC_ID = '1XlcAy-vrleXBxJl5Qy_SxGUyTqcwdUIhyJI2BygpNEc';
const COPY_FILE_URL = 'https://www.googleapis.com/drive/v3/files/fileId/copy';
const GOOGLE_DOC_URL = 'https://docs.google.com/document/d/';
const REVOKE_TOKEN_URL = 'https://accounts.google.com/o/oauth2/revoke?token=';

let loggedIn = false;

/**
 * Initializes Google APIs client library for browser-side JavaScript (gapi)
 * and the button functions when script is loaded.
 */
function onGAPILoad() {
  document.getElementById('generate-note-btn').onclick = generateNote;
  document.getElementById('logout-btn').onclick = logout;
  document.getElementById('doc-name-input').value = 'gNote ' + getDate();

  gapi.client.init({
    apiKey: API_KEY,
    discoveryDocs: DISCOVERY_DOCS,
  }).then(function() {
    chrome.identity.getAuthToken({interactive: true}, function(token) {
      if (chrome.runtime.lastError) {
        return;
      }
      loggedIn = true;
      setAuthStatus();
      gapi.auth.setToken({
        access_token: token,
      });
    })
  }, function(error) {
    console.log('error', error)
  });
}

/**
 * Generates a copy of the notes template and opens a new tab
 * with the newly created Google Doc.
 */
function generateNote() {
  // TODO: Add generate note functionality
}

/** Logs out the user by revoking their authentication token. */
function logout() {
  chrome.identity.getAuthToken({interactive: false}, function(token) {
    var url = REVOKE_TOKEN_URL + token;
    window.fetch(url);

    chrome.identity.removeCachedAuthToken({token: token}, function (){
      loggedIn = false;
      setAuthStatus();
    });
  })
}

/**
 * Displays the user's email info and logout button if the user
 * is logged in. Otherwise, hide them.
 */
function setAuthStatus() {
  if(loggedIn) {
    chrome.identity.getProfileUserInfo(function(userInfo) {
      document.getElementById('logout-btn').style.display = 'inline';
      document.getElementById('email').textContent = userInfo.email;
      document.getElementById('user-info').style.display = 'block';
    });
  } else {
    document.getElementById('logout-btn').style.display = 'none';
    document.getElementById('email').textContent = "";
    document.getElementById('user-info').style.display = 'none';
  }
}