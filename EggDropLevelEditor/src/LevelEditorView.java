import java.awt.Canvas;
import java.awt.Color;
import java.awt.Graphics;


public class LevelEditorView extends Canvas {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2645537927295681832L;

	public LevelEditorView(int x, int y)
	{
		super();
		
		this.setBounds(x, y, 480, 320);
	}
	
	public void paint(Graphics g)
	{
		System.out.println(this.getX());
		g.setColor(Color.BLACK);
		g.fillRect(0, 0, this.getWidth(), this.getHeight());
	}
	
}
