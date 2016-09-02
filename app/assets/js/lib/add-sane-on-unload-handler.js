// Credit: http://stackoverflow.com/users/39013/josiah-ruddell
// http://stackoverflow.com/questions/4126820/window-onbeforeunload-may-fire-multiple-times

const NAVIGATE_AWAY_MESSAGE = 'This action will log you out of the game!';

export function addSaneOnUnloadHandler(promptBeforeLeaving = () => true) {
  let alreadPrompted = false;
  let timeoutID = 0;

  const reset = () => {
    alreadPrompted = false;
    timeoutID = 0;
  };

  window.onbeforeunload = () => {
    if (promptBeforeLeaving() && !alreadPrompted) {
      alreadPrompted = true;
      timeoutID = setTimeout(reset, 100);
      return NAVIGATE_AWAY_MESSAGE;
    }
    return null;
  };

  window.onunload = () => {
    clearTimeout(timeoutID);
  };
}
