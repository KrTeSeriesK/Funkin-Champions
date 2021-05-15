package;

import flixel.FlxG;

class ExSongData
{
	public static var ExtraSongData:Array<Dynamic> = ["Bopeebo-hard", 0, 0, 0, 0, 0, 0, 0, 0, 0]; //notemiss, perfect, perfected, sick, good, bad, shit, miss, score, song + difficulty
	
	public static function saveExSongData(n:Int = 0, p:Int = 0, pf:Int = 0, s:Int = 0, g:Int = 0, b:Int = 0, sh:Int = 0, m:Int = 0, score:Int = 0, song:String, ?diff:Int = 0):Void
	{
		var daSong:String = Highscore.formatSong(song, diff);

		if (Highscore.songScores.exists(daSong))
		{
			if (Highscore.songScores.get(daSong) < score)
				setExData(n,p,pf,s,g,b,sh,m,score,daSong);
		}
		else
			setExData(n,p,pf,s,g,b,sh,m,score,daSong);
	}
	
	static function setExData(n:Int = 0, p:Int = 0, pf:Int = 0, s:Int = 0, g:Int = 0, b:Int = 0, sh:Int = 0, m:Int = 0, score:Int = 0, song:String):Void
	{
		// Reminder that I don't need to format this song, it should come formatted!
		ExtraSongData.set(n,p,pf,s,g,b,sh,m,score,song);
		FlxG.save.data.ExtraSongData = ExtraSongData;
		FlxG.save.flush();
	}
	
	public static function getData(song:String, diff:Int):Int
	{
		if (!Highscore.songScores.exists(Highscore.formatSong(song, diff)))
			setExData(0, 0, 0, 0, 0, 0, 0, 0, 0,Highscore.formatSong(song, diff), 0);

		return ExtraSongData.get(Highscore.formatSong(song, diff));
	}

	public static function load():Void
	{
		if (FlxG.save.data.ExtraSongData != null)
		{
			ExtraSongData = FlxG.save.data.ExtraSongData;
		}
		else
		{
			setExData(0, 0, 0, 0, 0, 0, 0, 0, 0,Highscore.formatSong(song, diff), 0);
		}
	}
	
}