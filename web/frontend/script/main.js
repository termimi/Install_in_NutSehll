document.getElementById("button").addEventListener("click", function () {
    const downloadUrl = "/download";

    const link = document.createElement("a");
    link.href = downloadUrl;
    link.download = "script.ps1";
    link.click();
});