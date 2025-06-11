function applyTheme() {
  if(localStorage.getItem('theme') === 'dark') {
    document.body.classList.add('dark');
  } else {
    document.body.classList.remove('dark');
  }
}
window.addEventListener('DOMContentLoaded', applyTheme);
window.toggleTheme = function() {
  document.body.classList.toggle('dark');
  localStorage.setItem('theme', document.body.classList.contains('dark') ? 'dark' : 'light');
};