var navCases = document.querySelector("nav.nav-validation");
var allCases = navCases.querySelector("a.nav-filter-a");
var proposedCases = navCases.querySelector("a.nav-filter-1");
var runningCases = navCases.querySelector("a.nav-filter-2");
var validatedCases = navCases.querySelector("a.nav-filter-3");

var onAllCases = function () {
    var cases = document.querySelectorAll("div.case-validation");
    for (let index = 0; index < cases.length; index++) {
        cases[index].style.display = "";
    }
};

var onProposedCases = function () {
    var cases = document.querySelectorAll("div.case-validation");
    for (let index = 0; index < cases.length; index++) {
        cases[index].style.display = "none";
    }
    var cases = document.querySelectorAll("div.case-2");
    for (let index = 0; index < cases.length; index++) {
        cases[index].style.display = "";
    }
};

var onRunningCases = function () {
    var cases = document.querySelectorAll("div.case-validation");
    for (let index = 0; index < cases.length; index++) {
        cases[index].style.display = "none";
    }
    var cases = document.querySelectorAll("div.case-3");
    for (let index = 0; index < cases.length; index++) {
        cases[index].style.display = "";
    }
};

var onValidatedCases = function () {
    var cases = document.querySelectorAll("div.case-validation");
    for (let index = 0; index < cases.length; index++) {
        cases[index].style.display = "none";
    }
    var cases = document.querySelectorAll("div.case-1");
    for (let index = 0; index < cases.length; index++) {
        cases[index].style.display = "";
    }
};

allCases.addEventListener("click", onAllCases);
proposedCases.addEventListener("click", onProposedCases);
runningCases.addEventListener("click", onRunningCases);
validatedCases.addEventListener("click", onValidatedCases);

