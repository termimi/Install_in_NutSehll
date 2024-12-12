document.getElementById("button").addEventListener("click", function () {
    const downloadUrl = "http://localhost:3000/download";

    const link = document.createElement("a");
    link.href = downloadUrl;
    link.download = "script.ps1";
    link.click();
});