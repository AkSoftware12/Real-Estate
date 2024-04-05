// Api

/** 
const registerUser = "http://192.168.29.246/realestate/api/register";
const loginUser = "http://192.168.29.246/realestate/api/login";
const loggedInUser = "http://192.168.29.246/realestate/api/loogedInUser";
const addProperty = "http://192.168.29.246/realestate/api/upload";
const allProperties = "http://192.168.29.246/realestate/api/getAllProperties";
const viewproperties = "http://192.168.29.246/realestate/api/getPropertyDetails?id=13";
*/

const commonRequest = async (method, url, headers, data) => {
    try {
        const response = await axios({ method, url, headers, data });
        return response;
    } catch (error) {
        return error.response
    }
}


const loginFormData = document.getElementById("login");
loginFormData.addEventListener('submit', async function (e) {
    e.preventDefault();

    const email = loginFormData.querySelector('[name="email"]').value;
    const password = loginFormData.querySelector('[name="password"]').value;

    const parsedData = { email, password };
    const headers = {
        "Content-Type": "application/json"
    };
    try {
        const apiResponse = await commonRequest("POST", "http://192.168.29.246/realestate/api/login", headers, parsedData);
        console.log(apiResponse);
         
        if (apiResponse.status === 200) {
            Swal.fire({
                title: 'Login Successfully!',
                icon: 'success',
                confirmButtonText: 'Ok',
                confirmButtonColor: "#3085d6"
            })
            setTimeout(() => {
                window.location.href = "index.html";
            }, 2000);
        } else if (apiResponse.status === 401) {
            Swal.fire({
                title: apiResponse.data.message,
                icon: 'error',
                confirmButtonText: 'Try Again',
                confirmButtonColor: "#3085d6"
            })
        }
    } catch (error) {
        console.log(error);
    }
});