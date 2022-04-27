document.querySelectorAll(".mab").forEach((multiAction) => {
    multiAction.querySelector(".mab__button--menu");
    multiAction.querySelector(".mab__list");
});
// Create alert with instruction for parent
document.addEventListener("click", (e) => {
    const alertInfo =
        e.target.matches(".mab__list") ||
        e.target.matches(".mab__button--menu") ||
        e.target.closest(".mab__button--menu");

    //Hack to simplify/reduce code base 
    let str =
        "To Register your child:                                                                         (1) Click REGISTER and then 'PARENT'.                                              (2) Click MY STUDENTS tab                                                                  (3) Click 'ADD A STUDENT' link and complete form.                           The bank will supply you with a NO-FEE saving account FOR YOUR CHILD.";

    if (alertInfo) alert(str);
});
