# JSON Editor Online

This is a FOSS reimplementation of the website https://jsoneditoronline.org.
While the underlying library ``jsoneditor`` is freely available for use, the
highly functional website is not.

Obviously at this stage it is very much incomplete, and it's unlikely I'll
ever add all of the same functionality. At some stage I would like to add the
following:

- Diff support
- JSON schema support
- Changing indentation

## Usage

The script ``build.sh`` in the repository root is designed to generate a fully
static site that can be deployed anywhere. All of the necessary files will be
available in the ``dist`` folder after running the script. You can then deploy
the contents of the ``dist`` directory wherever you choose (it even works great
in a local environment).

The script will automatically install dependencies from NPM by running ``yarn
install``.

## License

This software is covered by the GNU Affero General Public License Version 3 only.
