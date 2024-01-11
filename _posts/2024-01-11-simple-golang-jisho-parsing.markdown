---
layout: post
title:  "⚗️ Parsing Jisho API with Golang"
date:   2024-01-10 10:40:32 +0100
categories: golang jisho json
---

# Parsing Jisho.org api with Golang

```golang


//code and structures to mine json from jisho.org

package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
)

type Status struct {
	Status string
}

type Japanese struct {
	Word string
	Reading string
}

type Sense struct {
	English_definitions []string
	Parts_of_speech []string
	Links []string
	Tags []string
	Restrictions []string
	//ommited...
}

type Attribution struct {
	Jmdict bool
	Jmnedict bool
	Bdpedia bool
}

type Data struct {
	Slug string `json:"slug"`
	Is_common bool
	Tags []string
	Jlpt []string
	Japanese []Japanese
	Senses []Sense
	Attribution Attribution
}

type Jisho struct {
	Status string `json:"status"`
	Data   []Data `json:"data"`
}

func main(){

	var jisho_response Jisho

	res, err := http.Get("http://beta.jisho.org/api/v1/search/words?keyword=house")

	if err != nil {
		fmt.Println(err.Error())
	}

	fmt.Println(res.StatusCode)

	resBody, _ := ioutil.ReadAll(res.Body)
	// fmt.Println(string(resBody))
	_ = json.Unmarshal([]byte(resBody), &jisho_response)

	for _, entry := range jisho_response.Data {
		fmt.Println(entry.Slug)
	}

}

```