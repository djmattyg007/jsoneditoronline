(function(root) {
    const appOnError = (err) => {
        window.jeLastError = err;
        alert(String(err));
    };

    const panelLeft = document.getElementById("panel-left");
    const panelRight = document.getElementById("panel-right");

    const startJson = {
        "array": [1, 2, 3],
        "boolean": true,
        "null": null,
        "number": 123,
        "object": { "a": "b", "c": "d" },
        "string": "Hello World",
    };

    const editorLeft = new JSONEditor(panelLeft, { mode: "code", onError: appError }, startJson);
    const editorRight = new JSONEditor(panelRight, { mode: "tree", onError: appOnError }, startJson);

    document.addEventListener("click", (evt) => {
        if (evt.target.matches("[data-app-action='to-left']")) {
            evt.target.focus();
            try {
                editorLeft.set(editorRight.get());
            } catch (err) {
                appOnError(err);
            }
        } else if (evt.target.matches("[data-app-action='to-right']")) {
            evt.target.focus();
            try {
                editorRight.set(editorLeft.get());
            } catch (err) {
                appOnError(err);
            }
        }
    });

    root.jeEditorLeft = editorLeft;
    root.jeEditorRight = editorRight;
})(window);
