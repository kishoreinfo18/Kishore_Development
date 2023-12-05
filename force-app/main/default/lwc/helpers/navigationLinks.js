/**
 * Look at the input string to see if it looks like an external URI or not
 * @param  {string}  val the input api page name or external link
 * @return {Boolean}     true if the val input begins with 'http://' or 'https://'
 */
const isExternalLink = val => {
    return val.startsWith("http://") || val.startsWith("https://");
};

export { isExternalLink };