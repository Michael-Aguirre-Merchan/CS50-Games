using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CanvasDontDestroy : MonoBehaviour
{
    public static CanvasDontDestroy instance = null;
    public int globalLevel = 1;
    public Text text;

    // singleton pattern; make sure only one of these exists at one time, else we will
    // get an additional set of sounds with every scene reload, layering on the music
    // track indefinitely

    void Awake()
    {
        if (instance == null)
        {
            instance = this;
            DontDestroyOnLoad(gameObject);
        }
        else if (instance != this)
        {
            Destroy(gameObject);
        }
    }
    void Start()
    {
        
    }

    void Update()
    {
        text.text = "Level: " + globalLevel;
    }
}
