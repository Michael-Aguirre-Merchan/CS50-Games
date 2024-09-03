using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class EndScript : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        DestroyImmediate(CanvasDontDestroy.instance.gameObject);
        DestroyImmediate(DontDestroy.instance.gameObject);
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetAxis("Submit") == 1)
        {
            SceneManager.LoadScene("Title");
        }
    }
}
