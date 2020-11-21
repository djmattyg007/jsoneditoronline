(function(root, doc) {
    function dragElement(elDragHandle, elSeparator, elLeftBox, elRightBox) {
        let md;
        elDragHandle.onmousedown = onMouseDown;

        function onMouseDown(e) {
            const leftWidth = elLeftBox.offsetWidth;
            const rightWidth = elRightBox.offsetWidth;
            md = {
                e,
                leftWidth,
                rightWidth,
                totalWidth: leftWidth + rightWidth,
            };

            doc.onmousemove = onMouseMove;
            doc.onmouseup = () => {
                doc.onmousemove = doc.onmouseup = null;
            }
        }

        function onMouseMove(e) {
            const delta = e.clientX - md.e.clientX;
            // Prevent negative-sized elements
            const adjDelta = Math.min(
                Math.max(delta, -md.leftWidth),
                md.rightWidth
            );

            const leftNewWidth = md.leftWidth + adjDelta;
            const rightNewWidth = md.rightWidth - adjDelta;

            const leftProportion = leftNewWidth / md.totalWidth;
            const rightProportion = rightNewWidth / md.totalWidth;

            elLeftBox.style.flexGrow = leftProportion;
            elRightBox.style.flexGrow = rightProportion;
        }
    }

    const panelLeft = doc.getElementById("panel-left");
    const panelRight = doc.getElementById("panel-right");
    const panelSep = doc.getElementById("panel-separator");
    const panelSepDragHandle = doc.getElementById("panel-separator-draghandle");

    dragElement(panelSepDragHandle, panelSep, panelLeft, panelRight);
})(window, document);
