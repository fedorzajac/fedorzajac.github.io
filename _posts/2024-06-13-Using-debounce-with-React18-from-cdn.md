---
layout: post
title:  "🪫 Using debounce with React18 from cdn"
date:   2024-06-13 07:57:14 +0200
categories: Using debounce with React18 from cdn
---

### Using debounce with React18 from cdn

```html
<html>
    <head>
        <title>React on Website</title>
    </head>
    <body>
        <div id="app"></div>



        <script type="text/babel" src="/react.js"></script>
        <script src="https://unpkg.com/react@18/umd/react.development.js" crossorigin></script>
        <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js" crossorigin></script>
        <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>

    </body>
</html>
```

and react code:

```javascript
const { useState, useEffect, useCallback, useMemo } = React;
const { debounce } = _;

const App = () => {

    const [query, setQuery] = useState('');
    const [results, setResults] = useState([]);

    const [executeDebouncer, setExecuteDebouncer] = useState(false);
    const debounceFetchResults = useCallback(
        debounce(() => setExecuteDebouncer(true), 3000),
        [],
    );

    const handleChange = (e) => {
        const newQuery = e.target.value;
        console.log(newQuery);
        setQuery(newQuery);
        debounceFetchResults();
    }

    const fetchResults = () => {
            console.log('debouncing...');
            fetch(`your url`)
            .then(response => response.json())
            .then(data => {
                setResults(data.features);
                console.log(data);
            })
            .catch(error => {
                console.error("Error fetching data", error);
            });
    }; // Debounce time in milliseconds

    useEffect(() => {
        if (executeDebouncer) {
          setExecuteDebouncer(false);
          fetchResults();
        }
      }, [executeDebouncer]);

    return (
        <React.Fragment>
            <div>
      <input
        type="text"
        value={query}
        onChange={handleChange}
        placeholder="Search..."
      />
      <ul>
        {results.map(result => (
          <li key={result.properties.osm_id + Math.random(1000)}>
           ...
          </li>
        ))}
      </ul>
    </div>
        </React.Fragment>
    );
}

let domContainer = document.querySelector('#app');
ReactDOM.render(<App />, domContainer);
```


---
[https://stackoverflow.com/questions/70501416/debug-usecallback-with-debouncer-resets-usestate-variables](https://stackoverflow.com/questions/70501416/debug-usecallback-with-debouncer-resets-usestate-variables)
