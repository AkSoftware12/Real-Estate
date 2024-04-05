// Back Btn
const backBtn = document.querySelector(".back-btn");

backBtn.addEventListener("click", function (e) {
    e.preventDefault();
    window.history.back();
});



// Filter Bar
const priceLow = document.querySelectorAll(".filter p");

priceLow.forEach((element)=>{
    element.addEventListener("click", function(){
        if(element.className == "active"){
            element.classList.remove("active");
        }else{
            element.classList.add("active");
            console.log(element.textContent);
        }
    })
})

// Rate Us Stars
const rateStars = document.querySelectorAll(".starChecker");
const star1 = document.querySelector(".starRate1");
const star2 = document.querySelector(".starRate2");
const star3 = document.querySelector(".starRate3");
const star4 = document.querySelector(".starRate4");
const star5 = document.querySelector(".starRate5");


rateStars.forEach((element)=>{
element.addEventListener("click", function(){
    if(element.attributes.for.value === "oneStar"){
        star1.classList.add("orangeColorForStar");

        star2.classList.remove("orangeColorForStar");
        star3.classList.remove("orangeColorForStar");
        star4.classList.remove("orangeColorForStar");
        star5.classList.remove("orangeColorForStar");
    }
    else if(element.attributes.for.value === "twoStar"){
        star1.classList.add("orangeColorForStar");
        star2.classList.add("orangeColorForStar");

        star3.classList.remove("orangeColorForStar");
        star4.classList.remove("orangeColorForStar");
        star5.classList.remove("orangeColorForStar");
    }
    else if(element.attributes.for.value === "threeStar"){
        star1.classList.add("orangeColorForStar");
        star2.classList.add("orangeColorForStar");
        star3.classList.add("orangeColorForStar");

        star4.classList.remove("orangeColorForStar");
        star5.classList.remove("orangeColorForStar");
    }
    else if(element.attributes.for.value === "fourStar"){
        star1.classList.add("orangeColorForStar");
        star2.classList.add("orangeColorForStar");
        star3.classList.add("orangeColorForStar");
        star4.classList.add("orangeColorForStar");

        star5.classList.remove("orangeColorForStar");
    }
    else if(element.attributes.for.value === "fiveStar"){
        star1.classList.add("orangeColorForStar");
        star2.classList.add("orangeColorForStar");
        star3.classList.add("orangeColorForStar");
        star4.classList.add("orangeColorForStar");
        star5.classList.add("orangeColorForStar");
    }
})
})