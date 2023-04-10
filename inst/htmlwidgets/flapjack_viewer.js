HTMLWidgets.widget({

    name: 'flapjack_viewer',

    type: 'output',

    factory: function(el, width, height) {

        // TODO: define shared variables for this instance

        return {

            renderValue: function(x) {

                const mapFile = new File(
                    [x.map],
                    "data.map", {
                    type: "text/plain",
                });

                const genFile = new File(
                    [x.gen],
                    "data.dat", {
                    type: "text/plain",
                });

                const mapTransfer = new DataTransfer();
                mapTransfer.items.add(mapFile);

                const genTransfer = new DataTransfer();
                genTransfer.items.add(genFile);

                const mapInput = document.createElement("input");
                mapInput.type = "file";
                mapInput.name = "mapfile"; // Add name property
                mapInput.id = "mapfile"; // Add id property
                mapInput.files = mapTransfer.files;

                const genInput = document.createElement("input");
                genInput.type = "file";
                genInput.name = "genofile"; // Add name property
                genInput.id = "genofile"; // Add id property
                genInput.files = genTransfer.files;


                var renderer = GenotypeRenderer();
                renderer.renderGenotypesFile({
                    domParent: "htmlwidget_container",
                    width: null, height: 600,
                    mapFileDom: mapInput,
                    genotypeFileDom: genInput,
                    overviewWidth: null, overviewHeight: 200,
                    minGenotypeAutoWidth: 600, minGenotypeAutoHeight: 600,
                });
            },

            resize: function(width, height) {

            // TODO: code to re-render the widget with a new size

            }

        };
    }
});
