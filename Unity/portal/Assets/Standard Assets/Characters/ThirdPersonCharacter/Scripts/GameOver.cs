using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class GameOver : MonoBehaviour
{
    public Text text;
    // Update is called once per frame
    void OnControllerColliderHit(ControllerColliderHit hit)
    {
        if (hit.gameObject.name == "GameOver")
        {
            text.text = "You Won!";
        }
    }
}
