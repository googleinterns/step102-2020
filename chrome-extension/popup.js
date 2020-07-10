import keys from './config.js';

const NOTES_TEMPLATE_DOC_ID = '1XlcAy-vrleXBxJl5Qy_SxGUyTqcwdUIhyJI2BygpNEc';

const GAPI_CLIENT_URL = 'https://apis.google.com/js/client.js?onload=initGAPI';
const REVOKE_TOKEN_URL = 'https://accounts.google.com/o/oauth2/revoke?token=';

const DISCOVERY_DOCS = [
  "https://docs.googleapis.com/$discovery/rest?version=v1",
  "https://www.googleapis.com/discovery/v1/apis/drive/v3/rest"
];

let loggedIn = false;

/**
 * Gets the script for Google APIs client library for browser-side
 * JavaScript (gapi), sets the button functions, and fills the input. 
 */
window.onload = function() {
  let scriptEl = document.createElement('script');
  document.head.appendChild(scriptEl);
  scriptEl.src = GAPI_CLIENT_URL;

  document.getElementById('generate-note-btn').onclick = generateNote;
  document.getElementById('logout-btn').onclick = logout;
  document.getElementById('doc-name-input').value = 'gNote ' + getDate();
}

/** Initializes gapi. */
window.initGAPI = function initGAPI() {
  gapi.client.init({
    apiKey: keys.API_KEY,
    discoveryDocs: DISCOVERY_DOCS,
  }).then(handleLogin)
  .catch(error => console.log('Error:', error));
}

/**
 * Requests user login (if necessary) then sets gapi access token
 * and displays user info in popup.
 */
function handleLogin() {
  chrome.identity.getAuthToken({interactive: true}, function(token) {
    if (chrome.runtime.lastError) {
      return;
    }
    gapi.auth.setToken({
      access_token: token,
    });
    loggedIn = true;
    setAccountInfo();
  })
}

/** Returns formatted string of today's date. */
function getDate() {
  const today = new Date();
  const dd = String(today.getDate()).padStart(2, '0');
  const mm = String(today.getMonth() + 1).padStart(2, '0');
  const yyyy = today.getFullYear();

  return mm + '/' + dd + '/' + yyyy;
}

/**
 * Generates a copy of the notes template and opens a new tab
 * with the newly created Google Doc.
 */
function generateNote() {
  // TODO: Add generate note functionality
}

/**
 * Logs out the user by revoking their authentication token and removing
 * it from the cache.
 */
function logout() {
  chrome.identity.getAuthToken({interactive: false}, function(token) {
    const url = REVOKE_TOKEN_URL + token;
    window.fetch(url);

    chrome.identity.removeCachedAuthToken({token: token}, function() {
      loggedIn = false;
      setAccountInfo();
    });
  })
}

/**
 * Displays the user's email and a logout button if the user
 * is currently logged in. Otherwise, hides them.
 */
function setAccountInfo() {
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