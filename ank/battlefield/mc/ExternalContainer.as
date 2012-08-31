// Action script...

// [Initial MovieClip Action of sprite 872]
#initclip 84
class ank.battlefield.mc.ExternalContainer extends MovieClip
{
    var _sGroundFile, InteractionCell, createEmptyMovieClip, Ground, _parent, Object1, Grid, Zone, Select, Pointer, Object2;
    function ExternalContainer()
    {
        super();
    } // End of the function
    function initialize(sGroundFile)
    {
        _sGroundFile = sGroundFile;
        this.clear();
    } // End of the function
    function clear()
    {
        InteractionCell.removeMovieClip();
        this.createEmptyMovieClip("InteractionCell", 100);
        if (Ground == undefined)
        {
            this.createEmptyMovieClip("Ground", 200);
            var _loc2 = new MovieClipLoader();
            _loc2.addListener(_parent._parent);
            _loc2.loadClip(_sGroundFile, Ground);
        }
        else
        {
            Ground.clear();
        } // end else if
        Object1.removeMovieClip();
        this.createEmptyMovieClip("Object1", 300);
        Grid.removeMovieClip();
        this.createEmptyMovieClip("Grid", 400);
        Zone.removeMovieClip();
        this.createEmptyMovieClip("Zone", 500);
        Select.removeMovieClip();
        this.createEmptyMovieClip("Select", 600);
        Pointer.removeMovieClip();
        this.createEmptyMovieClip("Pointer", 700);
        Object2.removeMovieClip();
        this.createEmptyMovieClip("Object2", 800);
    } // End of the function
} // End of Class
#endinitclip
